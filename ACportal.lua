local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Auto Portal " .. Fluent.Version,
    SubTitle = "Auto Join Portal Script",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "portal" }),
    Priority = Window:AddTab({ Title = "Portal Priority", Icon = "list-ordered" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- Variables
local selectedPortal = nil
local selectedPortalId = nil
local selectedTiers = {}
local autoJoinEnabled = false
local autoNextPortalEnabled = false
local portalPriorities = {}
local unitsEmptyTime = 0
local isMonitoringUnits = false

-- Initialize default priorities
for i = 1, 11 do
    portalPriorities[i] = i
end

-- Function to get all portals (unique names only)
local function getPortals()
    local portals = {}
    local portalNames = {}
    local success, result = pcall(function()
        local itemFrames = game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames
        
        for _, item in pairs(itemFrames:GetChildren()) do
            if item.Name:match("^portal") then
                local portalName = item.Name
                local idChild = item:FindFirstChild("_uuid_or_id")
                
                if idChild and idChild.Value then
                    -- Only add if this portal name hasn't been added yet
                    if not portalNames[portalName] then
                        portalNames[portalName] = true
                        table.insert(portals, {
                            name = portalName,
                            id = idChild.Value
                        })
                    end
                end
            end
        end
    end)
    
    if not success then
        warn("Error getting portals:", result)
        return {}
    end
    
    return portals
end

-- Function to get portal ID by name (gets any portal with that name)
local function getPortalIdByName(portalName)
    local success, id = pcall(function()
        local itemFrames = game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames
        
        for _, item in pairs(itemFrames:GetChildren()) do
            if item.Name == portalName then
                local idChild = item:FindFirstChild("_uuid_or_id")
                if idChild and idChild.Value then
                    return idChild.Value
                end
            end
        end
    end)
    
    if success and id then
        return id
    end
    return nil
end

-- Function to get current portal tier (monitors Select GUI)
local function getCurrentPortalTier()
    local success, tier = pcall(function()
        local selectGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Select")
        if not selectGui then
            return nil
        end
        
        local tierText = selectGui.Starting.Main.Wrapper.Container.InfoFrame.portal_depth.Text
        -- Match "Tier: x1.0" format
        local tierNumber = tonumber(tierText:match("x(%d+)%.?%d*"))
        return tierNumber
    end)
    
    if success and tier then
        print("Portal tier detected:", tier)
        return tier
    else
        warn("Failed to get portal tier")
        return nil
    end
end

-- Function to wait for Select GUI to appear
local function waitForSelectGui()
    local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
    local selectGui = playerGui:FindFirstChild("Select")
    
    if selectGui then
        return true
    end
    
    -- Wait for Select GUI to be added
    local timeout = 10
    local elapsed = 0
    
    while elapsed < timeout do
        selectGui = playerGui:FindFirstChild("Select")
        if selectGui then
            return true
        end
        wait(0.1)
        elapsed = elapsed + 0.1
    end
    
    return false
end

-- Function to check if ResultsUI is enabled
local function isGameEnded()
    local success, enabled = pcall(function()
        local resultsUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ResultsUI")
        return resultsUI and resultsUI.Enabled
    end)
    
    return success and enabled
end

-- Function to request portal (auto pick)
local function requestPortal()
    local success, result = pcall(function()
        local args = {
            [1] = 1
        }
        game:GetService("ReplicatedStorage").endpoints.client_to_server.RequestPortal:InvokeServer(unpack(args))
    end)
    
    if success then
        print("Auto picked portal")
        return true
    else
        warn("Failed to request portal:", result)
        return false
    end
end

-- Function to vote for replay portal (ingame start)
local function voteReplayPortal(portalId)
    local success, result = pcall(function()
        local args = {
            [1] = "replay_portal",
            [2] = portalId
        }
        game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
    end)
    
    if success then
        Fluent:Notify({
            Title = "Next Portal",
            Content = "Voted to replay portal!",
            Duration = 3
        })
        return true
    else
        warn("Failed to vote replay portal:", result)
        return false
    end
end

-- Function to monitor _UNITS folder
local function monitorUnitsFolder()
    if isMonitoringUnits then return end
    isMonitoringUnits = true
    
    task.spawn(function()
        while autoNextPortalEnabled do
            local unitsFolder = workspace:FindFirstChild("_UNITS")
            
            if unitsFolder then
                local childrenCount = #unitsFolder:GetChildren()
                
                if childrenCount == 0 then
                    unitsEmptyTime = unitsEmptyTime + 0.1
                    
                    if unitsEmptyTime >= 5 then
                        print("_UNITS empty for 5 seconds, requesting portal...")
                        if requestPortal() then
                            Fluent:Notify({
                                Title = "Auto Next Portal",
                                Content = "Picking random portal...",
                                Duration = 3
                            })
                        end
                        unitsEmptyTime = 0
                    end
                else
                    -- Reset timer when folder has children
                    unitsEmptyTime = 0
                end
            end
            
            wait(0.1)
        end
        
        isMonitoringUnits = false
        unitsEmptyTime = 0
    end)
end

-- Function to monitor ResultsUI and vote
local function monitorResultsUI()
    task.spawn(function()
        local lastState = false
        
        while autoNextPortalEnabled do
            local gameEnded = isGameEnded()
            
            -- Only trigger when state changes from false to true
            if gameEnded and not lastState then
                print("Game ended, voting to replay portal...")
                
                -- Get fresh portal ID
                if selectedPortal then
                    local portalId = getPortalIdByName(selectedPortal)
                    if portalId then
                        wait(1) -- Small delay before voting
                        voteReplayPortal(portalId)
                    else
                        Fluent:Notify({
                            Title = "Error",
                            Content = "Could not find portal ID for next round",
                            Duration = 3
                        })
                    end
                else
                    Fluent:Notify({
                        Title = "Error",
                        Content = "No portal selected for next round",
                        Duration = 3
                    })
                end
            end
            
            lastState = gameEnded
            wait(0.5)
        end
    end)
end

-- Function to check if tier is wanted
local function isTierWanted(tier)
    for selectedTier, enabled in pairs(selectedTiers) do
        if enabled then
            local tierNum = tonumber(selectedTier:match("(%d+)"))
            if tierNum == tier then
                return true
            end
        end
    end
    return false
end

-- Function to get highest priority tier from selected tiers
local function getHighestPriorityTier()
    local highestPriority = -1
    local bestTier = nil
    
    for selectedTier, enabled in pairs(selectedTiers) do
        if enabled then
            local tierNum = tonumber(selectedTier:match("(%d+)"))
            if portalPriorities[tierNum] and portalPriorities[tierNum] > highestPriority then
                highestPriority = portalPriorities[tierNum]
                bestTier = tierNum
            end
        end
    end
    
    return bestTier
end

-- Function to cancel portal
local function cancelPortal(portalId)
    local success, result = pcall(function()
        local args = {
            [1] = portalId
        }
        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_leave_lobby:InvokeServer(unpack(args))
    end)
    
    if success then
        Fluent:Notify({
            Title = "Portal Cancelled",
            Content = "Left the lobby - tier not wanted",
            Duration = 3
        })
        return true
    else
        warn("Failed to cancel portal:", result)
        return false
    end
end

-- Function to create portal
local function createPortal(portalId)
    local success, result = pcall(function()
        local args = {
            [1] = portalId
        }
        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_portal:InvokeServer(unpack(args))
    end)
    
    if success then
        Fluent:Notify({
            Title = "Portal Created",
            Content = "Successfully created portal!",
            Duration = 3
        })
        return true
    else
        Fluent:Notify({
            Title = "Error",
            Content = "Failed to create portal: " .. tostring(result),
            Duration = 5
        })
        return false
    end
end

-- Function to start portal
local function startPortal(portalId)
    local success, result = pcall(function()
        local args = {
            [1] = portalId
        }
        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
    end)
    
    if success then
        Fluent:Notify({
            Title = "Portal Started",
            Content = "Successfully started portal game!",
            Duration = 3
        })
        return true
    else
        Fluent:Notify({
            Title = "Error",
            Content = "Failed to start portal: " .. tostring(result),
            Duration = 5
        })
        return false
    end
end

-- Function to auto join portal with tier checking
local function autoJoinPortal()
    if not selectedPortal then
        Fluent:Notify({
            Title = "Error",
            Content = "Please select a portal first!",
            Duration = 3
        })
        return
    end
    
    if next(selectedTiers) == nil then
        Fluent:Notify({
            Title = "Error",
            Content = "Please select at least one tier!",
            Duration = 3
        })
        return
    end
    
    -- Get fresh portal ID
    selectedPortalId = getPortalIdByName(selectedPortal)
    
    if not selectedPortalId then
        Fluent:Notify({
            Title = "Error",
            Content = "Could not find portal ID!",
            Duration = 3
        })
        return
    end
    
    if createPortal(selectedPortalId) then
        -- Wait for Select GUI to appear
        Fluent:Notify({
            Title = "Waiting",
            Content = "Waiting for portal to load...",
            Duration = 2
        })
        
        if waitForSelectGui() then
            wait(0.5) -- Small delay to ensure GUI is fully loaded
            
            local currentTier = getCurrentPortalTier()
            
            if currentTier then
                if isTierWanted(currentTier) then
                    local highestPriorityTier = getHighestPriorityTier()
                    
                    if currentTier == highestPriorityTier then
                        Fluent:Notify({
                            Title = "Perfect Match!",
                            Content = "Tier " .. currentTier .. " (Highest Priority) - Starting portal...",
                            Duration = 3
                        })
                        wait(0.5)
                        startPortal(selectedPortalId)
                    elseif portalPriorities[currentTier] >= portalPriorities[highestPriorityTier] then
                        Fluent:Notify({
                            Title = "Good Match",
                            Content = "Tier " .. currentTier .. " - Starting portal...",
                            Duration = 3
                        })
                        wait(0.5)
                        startPortal(selectedPortalId)
                    else
                        Fluent:Notify({
                            Title = "Lower Priority Tier",
                            Content = "Tier " .. currentTier .. " - Cancelling for better tier...",
                            Duration = 3
                        })
                        wait(0.5)
                        cancelPortal(selectedPortalId)
                        
                        -- Wait for Select GUI to be removed
                        local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
                        local timeout = 10
                        local elapsed = 0
                        while playerGui:FindFirstChild("Select") and elapsed < timeout do
                            wait(0.1)
                            elapsed = elapsed + 0.1
                        end
                        
                        if autoJoinEnabled then
                            wait(1)
                            autoJoinPortal() -- Try again
                        end
                    end
                else
                    Fluent:Notify({
                        Title = "Tier Not Wanted",
                        Content = "Got Tier " .. currentTier .. " - Cancelling...",
                        Duration = 3
                    })
                    wait(0.5)
                    cancelPortal(selectedPortalId)
                    
                    -- Wait for Select GUI to be removed
                    local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
                    local timeout = 10
                    local elapsed = 0
                    while playerGui:FindFirstChild("Select") and elapsed < timeout do
                        wait(0.1)
                        elapsed = elapsed + 0.1
                    end
                    
                    if autoJoinEnabled then
                        wait(1)
                        autoJoinPortal() -- Try again
                    end
                end
            else
                Fluent:Notify({
                    Title = "Warning",
                    Content = "Could not detect portal tier",
                    Duration = 3
                })
            end
        else
            Fluent:Notify({
                Title = "Timeout",
                Content = "Portal GUI did not appear in time",
                Duration = 3
            })
        end
    end
end

do
    Fluent:Notify({
        Title = "Auto Portal Script",
        Content = "Script loaded successfully!",
        Duration = 5
    })

    -- Main Tab
    -- Get initial portals
    local initialPortals = getPortals()
    local initialPortalNames = {}
    
    for _, portal in ipairs(initialPortals) do
        table.insert(initialPortalNames, portal.name)
    end

    -- Portal dropdown
    local PortalDropdown = Tabs.Main:AddDropdown("PortalDropdown", {
        Title = "Select Portal",
        Values = initialPortalNames,
        Multi = false,
        Default = 1,
    })

    PortalDropdown:OnChanged(function(Value)
        selectedPortal = Value
        
        Fluent:Notify({
            Title = "Portal Selected",
            Content = "Selected: " .. Value,
            Duration = 2
        })
    end)

    -- Tier multi-dropdown
    local tierValues = {}
    for i = 1, 11 do
        table.insert(tierValues, "Tier " .. i)
    end

    local TierDropdown = Tabs.Main:AddDropdown("TierDropdown", {
        Title = "Select Tier",
        Description = "Select which tiers you want to join",
        Values = tierValues,
        Multi = true,
        Default = {},
    })

    TierDropdown:OnChanged(function(Value)
        selectedTiers = Value
        local selectedTiersList = {}
        for tier, state in pairs(Value) do
            if state then
                table.insert(selectedTiersList, tier)
            end
        end
        
        if #selectedTiersList > 0 then
            Fluent:Notify({
                Title = "Tiers Selected",
                Content = table.concat(selectedTiersList, ", "),
                Duration = 2
            })
        end
    end)

    -- Refresh portals button
    Tabs.Main:AddButton({
        Title = "Refresh Portal",
        Description = "Update the portal list with new portals",
        Callback = function()
            local portals = getPortals()
            local portalNames = {}
            
            for _, portal in ipairs(portals) do
                table.insert(portalNames, portal.name)
            end
            
            if #portalNames > 0 then
                PortalDropdown:SetValues(portalNames)
                Fluent:Notify({
                    Title = "Portals Refreshed",
                    Content = "Found " .. #portalNames .. " unique portal(s)",
                    Duration = 3
                })
            else
                Fluent:Notify({
                    Title = "No Portals Found",
                    Content = "No portals in your inventory",
                    Duration = 3
                })
            end
        end
    })

    -- Auto join toggle
    local StartPortalToggle = Tabs.Main:AddToggle("StartPortal", {
        Title = "Start Portal", 
        Default = false
    })

    StartPortalToggle:OnChanged(function()
        autoJoinEnabled = Options.StartPortal.Value
        
        if autoJoinEnabled then
            Fluent:Notify({
                Title = "Auto Join Enabled",
                Content = "Portal will be created and started",
                Duration = 3
            })
            autoJoinPortal()
        else
            Fluent:Notify({
                Title = "Auto Join Disabled",
                Content = "Portal auto join stopped",
                Duration = 3
            })
        end
    end)

    -- Auto Next Portal toggle
    local AutoNextPortalToggle = Tabs.Main:AddToggle("AutoNextPortal", {
        Title = "Auto Next Portal",
        Description = "Warning: This will pick a random tier",
        Default = false
    })

    AutoNextPortalToggle:OnChanged(function()
        autoNextPortalEnabled = Options.AutoNextPortal.Value
        
        if autoNextPortalEnabled then
            if not selectedPortal then
                Fluent:Notify({
                    Title = "Error",
                    Content = "Please select a portal first!",
                    Duration = 3
                })
                Options.AutoNextPortal:SetValue(false)
                return
            end
            
            Fluent:Notify({
                Title = "Auto Next Portal Enabled",
                Content = "Will automatically continue to next portal",
                Duration = 3
            })
            
            -- Start monitoring
            monitorUnitsFolder()
            monitorResultsUI()
        else
            Fluent:Notify({
                Title = "Auto Next Portal Disabled",
                Content = "Stopped monitoring for next portal",
                Duration = 3
            })
        end
    end)

    -- Priority Tab
    Tabs.Priority:AddParagraph({
        Title = "Portal Priority System",
        Content = "Set priority for each tier (higher number = higher priority).\nThe script will try to get the highest priority tier from your selected tiers."
    })

    -- Create priority inputs for each tier
    for i = 1, 11 do
        local PriorityInput = Tabs.Priority:AddInput("Tier" .. i .. "Priority", {
            Title = "Tier " .. i .. " Priority",
            Default = tostring(i),
            Placeholder = "Enter priority number",
            Numeric = true,
            Finished = true,
            Callback = function(Value)
                local priority = tonumber(Value)
                if priority then
                    portalPriorities[i] = priority
                    Fluent:Notify({
                        Title = "Priority Updated",
                        Content = "Tier " .. i .. " priority set to " .. priority,
                        Duration = 2
                    })
                end
            end
        })
    end

end

-- Addons
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("AutoPortalScript")
SaveManager:SetFolder("AutoPortalScript/config")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Ready",
    Content = "Auto Portal Script is ready to use!",
    Duration = 5
})

SaveManager:LoadAutoloadConfig()
