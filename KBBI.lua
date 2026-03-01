local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local dict = {
	a = {
		"aba","abad","abadi","abah","abai","abang","abar","abas","abdomen","abdi","aberasi",
		"abjad","ablasi","abnormal","abolisi","aborsi","abrasi","absen","absensi","absolut",
		"absorpsi","abstrak","absurd","abu","abuh","abur","acak","acara","acar","acuh","acung",
		"ada","adab","adat","adaptasi","adapun","adegan","adik","adil","adipati","administrasi",
		"administrator","adopsi","adu","aduh","aduk","adun","advokat","aerobik","afeksi","afiat",
		"agah","agak","agam","agama","agamis","agen","agenda","agih","agitasi","agresi","agresif",
		"agraria","agung","agus","ahad","ahli","ahwal","aib","air","ajar","ajak","ajal","ajang",
		"ajek","aji","ajir","ajuk","ajun","akademi","akademik","akal","akan","akar","akas",
		"akibat","akidah","akik","akil","akomodasi","akrab","akreditasi","aksi","aktif","aktor",
		"aktual","aku","akur","akurasi","akurat","akustik","akut","alam","alamat","alami","alang",
		"alap","alas","alat","alau","alel","alergi","alih","alim","alir","alis","alit","aljabar",
		"alkohol","allah","almanak","almarhum","alokasi","alot","alpa","altar","alternatif",
		"alu","alun","alur","alusi","amah","amal","amanah","amanat","amang","amar","amat","amatir",
		"ambai","ambil","ambisi","ambisius","ambrol","ambruk","ameba","amendemen","amis","amit",
		"amok","amonia","amor","ampas","ampat","ampun","amulet","amunisi","anak","analisis",
		"analog","analogi","anarki","aneh","aneka","anemia","angin","angka","angkat","angker",
		"angkuh","angkut","angsa","angsur","anjing","anjlok","anjung","anjur","anomali","anonim",
		"antah","antar","antara","antik","antipati","antisipasi","antologi","antonim","antusias",
		"anu","anugerah","angin","anyam","anyar","anyir","apa","apabila","apak","apam","aparat",
		"apartemen","apatis","apel","aplikasi","apresiasi","apung","arab","arah","arak","arang",
		"aransemen","aras","arif","arisan","aristokrasi","arit","aritmetika","arogan","aroma",
		"aromatik","arsip","arsitek","arsitektur","arti","artikel","artikulasi","artis","artistik",
		"aruh","arus","arwah","asah","asal","asam","asap","asar","asas","asasi","asbes","asep",
		"aset","asih","asimilasi","asin","asing","asisten","asli","asma","asmara","aspal","aspek",
		"aspirasi","asrama","asri","asuransi","atas","atau","ateis","atensi","atlet","atletik",
		"atmosfer","atom","atraksi","atribut","atur","audiensi","aula","aung","aura","aurat",
		"aurora","aut","autentik","autonomi","ayah","ayam","ayat","ayu","ayun","azab","azam",
		"azan","azimat","azimut",
	},
	b = {
		"bab","baba","babad","babak","babal","baban","babat","babi","bacah","bacak","bacang",
		"baca","bacok","bacot","badai","badak","badan","badut","bagaimana","bagak","bagan","bagi",
		"baginda","bagus","bahaya","bahasa","bahagia","bahkan","bahu","bahwa","baik","bait","baja",
		"bajak","baju","bak","bakal","bakar","bakat","bakau","bakeri","bakteri","bakti","baku",
		"bakul","bakung","balada","balai","balam","balang","balas","balau","balela","balet","balik",
		"balon","balok","balsam","balu","balut","ban","bana","banal","banang","banar","banas","bancah",
		"banci","banda","bandang","bandar","bandara","bandel","bandera","banding","bandit","bando",
		"bandung","bang","bangai","bangga","bangkai","bangkal","bangkang","bangkrut","bangku","bangsa",
		"bangun","bani","banjir","bank","bantah","bantai","bantal","banteng","banting","bantu","banyak",
		"barang","barangkali","barat","barbar","baret","baring","baris","bariton","baru","barua","baruh",
		"barung","barusan","barzanji","basa","basah","basil","basis","baskara","basket","basmi","basuh",
		"bata","batal","batalion","batang","batas","batik","batin","batu","batuk","bau","bauksit",
		"baur","bawa","bawah","bawang","bawel","baya","bayam","bayan","bayang","bayar","bayi","bayonet",
		"bayu","bazar","beasiswa","bebal","beban","bebas","bebat","bebek","beda","bedah","bedak","bedil",
		"begar","begawang","begini","begitu","beka","bekal","bekas","beken","beku","bela","belah","belai",
		"belaka","belakang","belam","belang","belanja","belantara","belas","belat","belati","belenggu",
		"beli","belia","beliau","belibis","belimbing","beling","belit","belo","belok","belot","belum",
		"belut","benak","benalu","benam","benang","benar","bencana","benci","benda","bendahara","bendera",
		"benderang","bendi","bendung","bengak","bengal","bengawan","bengkak","bengkel","bengkok","bengkudu",
		"bengong","benih","bening","benjol","bensin","bentak","bentang","benteng","bentuk","benua","benur",
		"benyai","berani","berandal","berantas","beras","berat","berita","beritawan","berkah","berkas",
		"berkat","berlian","bernas","bersih","bersin","bertih","besar","besok","bestari","betah","betul",
		"biadab","biak","biang","biar","biara","biarawan","bias","biasa","biawak","biaya","bicara","bidan",
		"bidang","biduri","bijak","bijaksana","biji","bijih","bikin","bila","bilal","bilang","bilas","bilik",
		"bilis","bimbang","bimbing","bina","binal","binar","binasa","binatang","binatu","biner","bintang",
		"bintara","bintik","biru","bisik","bising","biskuit","bismillah","bisnis","bisu","bisul","boga",
		"bogem","bohong","boikot","bola","boleh","bolong","bolos","bolpoin","bom","boneka","bong","bongkar",
		"bonsai","bonus","bopeng","bor","boraks","borang","borek","borgol","borok","borong","boros","bosan",
		"botani","botol","boya","boyong","brahma","brahmana","buku","bungalow","buah","buai","bual","buana",
		"buang","buas","buat","buaya","bubar","bubuh","bubuk","bubur","bubut","budak","budaya","budi","bugil",
		"buih","bujang","bujuk","bujur","bukit","bukti","bulat","bulan","bulu","bumi","bumbu","bunga","bungkam",
		"bungkuk","bungkus","bungsu","bungur","bunuh","bunyi","bupati","buru","buruh","buruk","burung","busa",
		"busana","busuk","busung","busur","buta","butir","butuh","buyar","buyung",
	},
	c = {
		"cabai","cabang","cabik","cabul","cacah","cacar","cacat","caci","cacing","cagar","cahaya",
		"cair","cakap","cakram","cakrawala","cakup","calon","campur","canda","candak","candi","candu",
		"canggih","canggung","cangkang","cangkir","cangkul","cantik","canting","cantum","capaian","capai",
		"cara","carik","carter","carut","catat","catur","cawat","cebok","cedera","cegah","cegat","cek",
		"cekal","cekam","cekat","cekik","ceking","cekok","cela","celah","celak","celaka","celana","celang",
		"celengan","celik","celoteh","cemas","cemara","cemberut","cemburu","cemerlang","cemeti","cemooh",
		"cendekia","cendekiawan","cenderung","cendol","cengkeh","cengkeram","cengkerik","centeng","cepat",
		"ceplas","ceplos","cerah","cerai","ceramah","cerdas","cerdik","cerita","cermat","cermin","cerna",
		"ceroboh","cerobong","cerpen","ceruk","cetakan","cetak","cetar","cetek","cetus","cewek","cita",
		"cinta","ciri","cirit","cocok","cokelat","cokmar","colong","comberan","condong","contoh","cor",
		"corak","coret","corong","coba","coblos","cuaca","cuai","cubit","cuci","cucu","cucuk","cucuran",
		"cukup","cukur","cula","culas","cuma","cumi","curang","curi","curiga","cut","cuti",
	},
	d = {
		"daerah","dagel","daging","dagu","dahaga","dahak","dahan","dahsyat","dahulu","dalam","dalang",
		"dalih","dalil","damai","damar","dampak","dan","dana","danau","dandang","danda","dansanak","dapur",
		"dara","darah","darat","dari","daripada","darma","darurat","dasa","dasar","data","datang","datar",
		"datu","datuk","daulat","daun","daur","dawai","dawet","daya","dayang","dayung","dayus","debu",
		"debut","decak","dedak","dedikasi","deduksi","demi","demikian","demografi","demokrasi","demokrat",
		"demon","denda","dendam","dendang","dengan","dengar","dengki","dengkul","dengkur","denim","depan",
		"depa","derai","derajat","derak","deras","derita","derivasi","derma","dermaga","dermawan","deru",
		"desain","desak","desember","desentralisasi","detik","detonasi","dewa","dewasa","dewi","diam",
		"diare","didik","diferensiasi","difusi","digital","diksi","dimensi","dinamika","dinamis","dinamit",
		"dinas","dinasti","dinding","dingin","dini","dinosaurus","diode","diploma","diplomasi","diplomat",
		"diri","dirus","doa","dobrak","dokter","doktor","doktrin","dokumen","dolan","dolar","domba",
		"domestik","dominan","dominasi","donasi","dongak","dongeng","dongkrak","dongkol","dosa","dosen",
		"draf","drama","dramatik","dramatikus","dua","duafa","duka","dukun","dukung","dunia","duniawi",
		"duplikasi","durhaka","duri","durian","dusta","dusun","duta",
	},
	e = {
		"edan","edar","edisi","edit","editor","edukasi","efek","efektif","efisien","egois","egoisme",
		"egrang","ejek","eja","ejakulasi","ekonomi","ekonomis","ekosistem","ekosfer","ekspansi","ekspedisi",
		"ekspor","ekspresi","elastis","elegan","eliminasi","emang","emansipasi","emas","emosi","emosional",
		"empat","empati","emping","empuk","emulsi","enak","enam","energi","enggak","enggan","engkau",
		"entah","enteng","enzim","episentrum","epok","era","eradikasi","erang","erat","erosi","erotis",
		"esa","esai","eskader","eskalasi","estetika","etika","etiket","etnik","etnis","evolusi","ewa",
		"excavata","excellency","excoecaria","eximia","exodus","exocarpus","expat","expor","extralarge",
	},
	f = {
		"faedah","fajar","fakih","fakir","fakta","faktor","faktur","falsafah","famili","fana","fanatik",
		"fanatisme","fantasi","fardu","faring","farmasi","fasih","fasik","fasilitas","fasis","fasisme",
		"fatal","fatwa","fauna","favorit","februari","federal","federasi","feminisme","feodal","feodalisme",
		"fermentasi","fertil","fertilisasi","figur","fikih","fiksi","fiktif","filsafat","filsuf","filter",
		"final","finansial","firasat","firma","firman","fisik","fisika","fitnah","fitrah","fitri","formal",
		"formalitas","formasi","format","formula","foto","fotografi","fotosintesis","fragmen","fraksi",
		"frasa","frustrasi","fundamental","fundamentalis","fungsi","fungsional",
	},
	g = {
		"gabah","gabung","gabus","gadai","gadang","gadis","gado","gagah","gagal","gagap","gagas","gairah",
		"gajah","gaji","galak","galaksi","galah","galang","galau","galeri","gali","galih","galong","galur",
		"gama","gamak","gamang","gambar","gambir","gamblang","gambus","gamelan","gamet","ganas","gancang",
		"ganda","gandeng","gandrung","gandum","ganggu","ganja","ganjal","ganjil","ganteng","ganti","gantung",
		"garang","garansi","garasi","garuda","garuk","gas","gasak","gasing","gatal","gatra","gaya","gayung",
		"gegar","gejala","gejolak","gelak","gelam","gelang","gelap","gelar","gelas","gelatik","gelembung",
		"geleng","gelincir","gelinding","gelisah","gema","gemas","gembira","gembok","gempa","gempar","gemuk",
		"gemulung","gemuruh","genap","gencar","gencatan","gending","gendut","genealogi","generasi","generatif",
		"genius","genjah","genjot","genom","genosida","genta","gentar","genting","genus","geografi","geologi",
		"gerak","gerak","geram","gerang","geraham","gerang","gerbang","gereja","gerik","gerilya","gering",
		"gerobak","gerombol","gertak","gesa","gesit","getah","getir","getol","gigih","gigil","gigit","gila",
		"gilap","gilas","gilir","ginjal","girang","gizi","global","globalisasi","golak","golek","golong",
		"gondok","gondrong","goreng","gotong","gotri","goyang","grad","gradasi","grafik","granat","grasi",
		"gravitasi","guru","guruh","gunung","guna","gunting","guntur","gusur","gusar","gusi","gusti",
	},
	h = {
		"habis","hadap","hadas","hadiah","hadir","hadirin","hadis","hafal","hak","hakikat","hakiki","hakim",
		"halal","halaman","halang","halau","halus","halusinasi","hama","hambar","hambat","hambur","hamil",
		"hampa","hampir","hancur","handuk","hangat","hangus","hantam","hantu","hanya","hanyut","harap",
		"harga","hari","harimau","haris","harkat","harmoni","harmonika","harmonisasi","harta","hartawan",
		"haru","harum","harus","hasad","hasil","hasrat","hati","haur","hawa","hayat","hayati","heban",
		"hebat","heboh","hemat","hening","herba","herbisida","heran","heroik","heroin","heroisme","hewani",
		"hidayah","hidung","hidup","hierarki","hikayat","hikmah","hikmat","hilang","hilir","hina","hindar",
		"hingga","hitam","hitung","hobi","holisme","honor","honorarium","hormat","hormon","hukum","hutan",
	},
	i = {
		"ibadah","ibu","icak","ideal",

"ifah","ifrit","iftar","iftitah","ifra","ifrikiyah","identitas","idola","idrak","ikhlas","ikhtiar","ikhtisar","iklan",
		"iklim","ikut","ilahi","ilmu","ilmuwan","ilustrasi","imajinasi","iman","imanen","imbal","imbang",
		"imbas","imigrasi","imitasi","impak","impas","impor","improvisasi","imun","imunisasi","incar",
		"indah","induk","induksi","industri","infak","inflasi","informasi","ingin","ingat","ingkar","ini",
		"inisiatif","inovasi","inspirasi","instruksi","instrumen","inti","intip","intuisi","invasi","iri",
		"irigasi","irama","ironi","ironis","isa","iseng","isi","isim","islam","islami","istana","istimewa",
		"istirahat","istri","itu","izin",
	},
	j = {
		"jaat","jabat","jaga","jagal","jagat","jago","jagung","jahat","jahe","jahil","jahit","jail","jaja",
		"jajah","jajan","jajar","jaka","jaket","jaksa","jala","jalak","jalan","jalang","jalar","jalin",
		"jalu","jalur","jamaah","jamak","jaman","jamban","jaminan","jamur","janabah","janah","janda","jangan",
		"janggal","janggut","jangka","jangkah","jangkar","jangkau","jangkit","jantan","jantung","januari",
		"janur","jariah","jari","jaring","jarum","jas","jasa","jasad","jasmaniah","jatah","jati","jatuh",
		"jauh","jauhar","jawab","jawara","jaya","jeda","jejas","jejaka","jejer","jelatang","jelas","jelata",
		"jelita","jemu","jemur","jenaka","jenat","jenazah","jendela","jenderal","jengkel","jenis","jenius",
		"jenjang","jenuh","jiwa","jihad","jijik","jika","jilat","jilbab","jimat","jinak","jintan","joget",
		"jodoh","jorok","jorong","jual","juang","juara","jubah","judi","judul","juga","jujur","jumlah",
		"jumpa","juni","junior","junjung","jurus","justru","juta","jutawan",
	},
	k = {
		"knalpot","kaabah","kabar","kabaret","kabel","kabinet","kabul","kabupaten","kabur","kabut","kaca","kacang",
		"kacau","kadang","kadar","kader","kadmium","kafir","kagum","kaidah","kain","kaisar","kait","kajang",
		"kajian","kaji","kakak","kaki","kaktus","kaku","kala","kalah","kalam","kalang","kalap","kalaupun",
		"kali","kalimat","kalori","kalung","kambing","kamar","kami","kamis","kampung","kampus","kamu",
		"kamuflase","kamus","kanak","kanal","kanan","kanker","kantong","kantor","kantuk","kaos","kapal",
		"kapan","karang","karaoke","karena","karakter","karat","karir","karya","karyawan","kasih","kasihan",
		"kasar","kasatmata","kaset","kasih","kata","katabalik","katakunci","kawah","kawan","kawat","kawin",
		"kaya","kayak","kayu","ke","kebal","kebaya","kebersihan","kebun","keburu","kecam","kecewa","keciwa",
		"kecil","kecurangan","kedua","kelas","keluarga","keluar","keliling","kelobot","kemah","kemarin",
		"kemal","kembali","kembang","kembar","kemudi","kenangan","kenapa","keras","keramat","kerja","keris",
		"kerjasama","ketika","khotbah","khusus","kilat","kini","kiri","kirim","kisah","kodrat","kompak",
		"komunitas","kota","kuasa","kuat","kurang","kursi","kurus",
	},
	l = {
		"laba","labah","labur","lacak","laci","lafal","laga","lagak","lagi","lagu","laguna","lahir",
		"lain","laju","lajur","laki","lakon","laksa","laksana","laku","lalu","lama","lamar","lapar",
		"lapang","lapor","larat","lari","larik","laris","larut","larva","las","latih","layak","layan",
		"layang","layar","layat","layu","lazim","lebah","lebih","legak","legal","legenda","lemah","lemak",
		"lemang","lemas","lembaga","lembah","lembap","lembar","lembut","lengkap","lentera","letak","lezat",
		"liberal","libur","licik","licin","lidah","lihat","lilin","limas","lincah","lingkup","lingkungan",
		"luar","lugas","lugu","luhur","lulus","lumayan","lumpur","lumrah","lunglai","lunak","lunas","lurus",
		"luwes",
	},
	m = {
		"maaf","mabuk","macam","macan","macet","madu","madya","maha","mahal","mahkamah","mahkota","mahasiswa",
		"mahir","majalah","majas","majikan","maju","makan","makin","makna","maklum","makna","malam","malang",
		"malap","malaria","malas","malu","manah","manajemen","manajer","manakala","manfaat","mangan","mangga",
		"mangkuk","mangsa","manja","manjur","mantan","mantap","mantra","manusia","manusiawi","marak","marah",
		"martabat","martil","masalah","masak","masam","masih","masuk","masyarakat","mati","maupun","maut",
		"mawas","mayat","media","medis","meditasi","megah","melati","melek","melodi","memang","memar","menarik",
		"menang","menara","mencari","mendung","mengerti","mengalir","mengapa","menikah","menteri","merdeka",
		"merdu","merek","mereka","muda","mudah","mungkin","murah","murai","murid","murni","mutu",
	},
	n = {
		"nama","nada","nadi","nadir","nafas","nafkah","nafsu","naga","naik","najis","nakal","nalar",
		"naluri","nanas","nanti","napal","napas","narasi","narkotik","narsis","nasib","nasional","naskah",
		"natal","natur","natural","naung","negara","negarawan","negasi","negatif","negeri","nekad","nekat",
		"nenek","niat","nilai","niscaya","nista","nitrat","nitrogen","noda","nomor","norma","normal","nuansa",
		"nubuat","nujum","nuri","nurani","nusa","nusantara","nyala","nyaman","nyamuk","nyana","nyanyian",
		"nyaring","nyata","nyawa","nyeri",
		-- NJ words
		"njlimet","njelimet","njomplang","njeplak","njeblos","njungkel","njepret","njanur",
		"njengkang","njengking","njepit","njeprak","njerit","njitak","njlentrehkan","njogrog",
		"njoget","njorok","njumput","njupuk","njungkir","njawab","njaluk","njalari","njaga",
		"njagong","njajal","njakarta","njaluk","njamah","njarak","njarah","njarum","njawil",
		"nganga","ngap","ngalau","ngambek","ngantuk","ngarai","ngawur","ngomong","ngobrol","ngotot",
		"ngeri","ngilu","ngidam","nginap","ngoceh","ngomel","ngopi","ngos","nguap","ngulet","ngunyah",
		"ngupas","ngurut","ngusir","ngebut","ngemil","ngengat","ngenyek","ngeong","ngeres","ngiang",
		"ngecas","ngecat","ngedrop","ngehek","ngelap","ngelayap","ngelesot","ngeliat","ngemeng",
		"ngendon","ngerti","ngeyel","nginep","ngirim","ngitung","ngocol","ngorbut","nguber","ngucap",
		"nguras","ngacir","ngaco","ngadat","ngaduh","ngajak","ngajarin","ngakak","ngakngik","ngambil",
		"ngamuk","nganggur","nganjur","ngantri","ngapain","ngasal","ngasih","ngata","ngatur","ngaus",
		"ngayuh","ngebahas","ngeband","ngebantu","ngebas","ngebawa","ngebel","ngeblok","ngebom",
		"ngebor","ngebuat","ngebuk","ngecat","ngecek","ngecengin","ngecet","ngecor","ngecup",
		"ngedarin","ngedik","ngedrop","ngefans","ngefly","ngegame","ngegombal","ngegor","ngehindarin",
		"ngejar","ngejek","ngejual","ngejut","ngekos","ngelap","ngelarin","ngeliatin","ngelola",
		"ngeluh","ngelus","ngemeng","ngemix","ngemop","ngemut","ngena","ngenain","ngendap","ngepasin",
		"ngepel","ngeprank","ngepung","ngerawat","ngerebut","ngeri","ngeringis","ngeroll","ngesah",
		"ngesot","ngetem","ngetik","ngetop","ngetwit","ngeup","ngevlog","ngewarnain","ngeyel",
		"ngibulin","ngiler","ngirim","ngitung","ngobrolin","ngocol","ngode","ngomong","ngondek",
		"ngopos","ngopi","ngorbit","ngos","ngotot","nguber","ngucap","ngudek","ngulek","ngundat",
		"ngunyah","ngupil","nguras","ngurung","ngusil","ngusir","ngutak",
	},
	o = {
		"oseng","ospek","osilasi","osilator","osarium","obat","objek","objektif","obligasi","observasi","obsesi","olahraga","olah","oleh","operasi",
		"opini","organisasi","orang","orator","orbit","orde","organ","organik","ornamen",
	},
	p = {
		"pabrik","padat","pagi","pahala","paham","pahit","pahlawan","pakai","pakan","panas","panca",
		"pancasila","pandai","pandang","pangan","pangeran","panggil","pangkat","panik","panjang","panti",
		"pantun","paru","pasang","pasar","pasrah","pasti","patuh","patung","pecah","pedang","peduli",
		"pelajar","pelawak","pelajaran","peluang","pencak","pendidikan","pengaruh","penguasa","perahu",
		"perang","perlu","pikiran","pintar","pohon","politik","potensi","prestasi","pribadi","prinsip",
		"produk","proyek","puasa","pujangga","puji","pujuk","punya","purba","putih","putri","putra",
	},
	q = {
		"qalbu","qari","qariah",
	},
	r = {
		"raba","rabas","rabun","racik","racun","ragam","raih","raja","rajin","rakyat","rama","ramah",
		"ramai","ramal","rambut","rancang","rancangan","rasa","rasio","rasional","rasul","ratu","raya",
		"rayuan","reaksi","rela","relasi","religius","rencanakan","rendah","resah","resmi","risalah",
		"risau","rohani","rombak","rona","runding","runcing","runtuh","rupa","rupiah","rusa","rusak",
		"rusuh","ruwet",
	},
	s = {
		"saat","sabar","sabda","sabun","sahabat","sahaja","saham","sahdu","sahih","sakit","samudera",
		"sana","sandiwara","sanggup","santai","santun","sarana","sastra","sastrawan","satu","saudara",
		"sauh","saya","sehat","sejahtera","sejarah","semangat","sempurna","seni","seniman","senjata",
		"sering","setia","setiawan","siang","siap","sikap","simbol","simpati","sinar","singgah","sinis",
		"sistem","situasi","solidaritas","sopan","sosial","spirit","stabil","strategi","suara","suasana",
		"sudah","sukar","sukses","sumber","sungguh","sunyi","syukur",
	},
	t = {
		"taat","tabu","tahu","tahun","tajam","taman","tanah","tanggung","tanggap","tanya","tarik","taruh",
		"tayangan","teguh","teladan","tenang","tenar","tentram","tepat","terus","tian","tidak","tinggi",
		"tinggal","tirta","tujuan","tugas","tulus","tumpahan","tulus","turut",
	},
	u = {
		"ubah","uban","udara","uji","ujung","ular","ulang","ulur","umum","umur","unik","universal",
		"untuk","upah","uang","urut","usaha","usai","utama","utang","utara","utas","utuh",
		-- UKA words
		"ukas",
	},
	v = {
		"vaksin","vaksinasi","valid","validitas","variasi","varietas","vektor","verbal","vibran","viral",
		"virtual","virtualitas","visioner","vital","vitalitas","vitamin","vocal","vokal","vonis",
	},
	w = {
		"wabah","wajah","wajar","wajib","waktu","walau","wali","warga","warna","warsa","warta","wasiat",
		"waspada","watak","wawancara","wayang","wilayah","wira","wiraswasta","wirausaha","wisata","wisatawan",
	},
	x = {
		"xenofobia","xenofili","xenograf","xenokrasi","xenolit","xenomania","xenon","xenoglosia",
		"xerofil","xerofit","xeroftalmia","xerografi","xerosis","xifoid","xilem","xilena",
		"xilofon","xilograf","xilografi","xiloid","xiloidina","xilol","xilologi","xilonit","xilosa",
		"xantat","xantena","xantofil","xenia",
	},
	y = {
		"yakin","yakni","yang","yatim","yayasan","yaitu",
	},
	z = {
		"zahid","zakat","zalim","zaman","zamrud","zat","ziarah","zona","zonasi","zuhud",
	},
}

-- Gui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WF-V1"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Search Frame
local searchFrame = Instance.new("Frame")
searchFrame.Size = UDim2.new(0, 280, 0, 62)
searchFrame.Position = UDim2.new(0, 40, 0, 40)
searchFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
searchFrame.BorderSizePixel = 0
searchFrame.Active = true
searchFrame.Parent = screenGui
Instance.new("UICorner", searchFrame).CornerRadius = UDim.new(0, 10)
local ss = Instance.new("UIStroke", searchFrame)
ss.Color = Color3.fromRGB(70, 120, 255); ss.Thickness = 1.5

local dragBar = Instance.new("TextLabel")
dragBar.Size = UDim2.new(1, 0, 0, 28)
dragBar.BackgroundColor3 = Color3.fromRGB(40, 80, 200)
dragBar.TextColor3 = Color3.new(1,1,1)
dragBar.Font = Enum.Font.GothamBold
dragBar.TextSize = 13
dragBar.Text = "Indo Words Finder - By WnZ"
dragBar.BorderSizePixel = 0
dragBar.Parent = searchFrame
Instance.new("UICorner", dragBar).CornerRadius = UDim.new(0, 10)

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -16, 0, 28)
textBox.Position = UDim2.new(0, 8, 0, 30)
textBox.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
textBox.TextColor3 = Color3.new(1,1,1)
textBox.PlaceholderText = "Ketik kata..."
textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
textBox.Font = Enum.Font.GothamBold
textBox.TextSize = 15
textBox.ClearTextOnFocus = false
textBox.BorderSizePixel = 0
textBox.Parent = searchFrame
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 7)

-- Result Frame
local resultFrame = Instance.new("Frame")
resultFrame.Size = UDim2.new(0, 240, 0, 340)
resultFrame.Position = UDim2.new(0, 340, 0, 40)
resultFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
resultFrame.BorderSizePixel = 0
resultFrame.Active = true
resultFrame.Visible = false
resultFrame.Parent = screenGui
Instance.new("UICorner", resultFrame).CornerRadius = UDim.new(0, 10)
local rs = Instance.new("UIStroke", resultFrame)
rs.Color = Color3.fromRGB(70, 120, 255); rs.Thickness = 1.5

local resultDragBar = Instance.new("TextLabel")
resultDragBar.Size = UDim2.new(1, -34, 0, 28)
resultDragBar.BackgroundColor3 = Color3.fromRGB(40, 80, 200)
resultDragBar.TextColor3 = Color3.new(1,1,1)
resultDragBar.Font = Enum.Font.GothamBold
resultDragBar.TextSize = 12
resultDragBar.Text = "Hasil"
resultDragBar.BorderSizePixel = 0
resultDragBar.Parent = resultFrame
Instance.new("UICorner", resultDragBar).CornerRadius = UDim.new(0, 10)

-- Minimize/Close button on result panel
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Text = "-"
closeBtn.BorderSizePixel = 0
closeBtn.Parent = resultFrame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

-- Reopen button on search panel
local reopenBtn = Instance.new("TextButton")
reopenBtn.Size = UDim2.new(0, 28, 0, 28)
reopenBtn.Position = UDim2.new(1, -30, 0, 0)
reopenBtn.AnchorPoint = Vector2.new(0, 0)
reopenBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 80)
reopenBtn.TextColor3 = Color3.new(1,1,1)
reopenBtn.Font = Enum.Font.GothamBold
reopenBtn.TextSize = 14
reopenBtn.Text = "+"
reopenBtn.BorderSizePixel = 0
reopenBtn.Visible = false
reopenBtn.Parent = searchFrame
Instance.new("UICorner", reopenBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function()
	resultFrame.Visible = false
	reopenBtn.Visible = true
end)
reopenBtn.MouseButton1Click:Connect(function()
	if textBox.Text ~= "" then
		resultFrame.Visible = true
	end
	reopenBtn.Visible = false
end)

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -36)
scrollFrame.Position = UDim2.new(0, 5, 0, 32)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(70, 120, 255)
scrollFrame.CanvasSize = UDim2.new(0,0,0,0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.Parent = resultFrame

local listLayout = Instance.new("UIListLayout", scrollFrame)
listLayout.Padding = UDim.new(0, 3)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
local listPad = Instance.new("UIPadding", scrollFrame)
listPad.PaddingTop = UDim.new(0, 4)
listPad.PaddingLeft = UDim.new(0, 4)

-- Drag UI
local function makeDraggable(frame, handle)
	local drag, dragStart, startPos = false, nil, nil
	handle.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			drag = true; dragStart = i.Position; startPos = frame.Position
		end
	end)
	handle.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			drag = false
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local d = i.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
end
makeDraggable(searchFrame, dragBar)
makeDraggable(resultFrame, resultDragBar)

-- Search
local function clearWords()
	for _, c in ipairs(scrollFrame:GetChildren()) do
		if c:IsA("TextLabel") then c:Destroy() end
	end
end

local function showWords(query)
	clearWords()
	query = query:lower()
	if query == "" then resultFrame.Visible = false; return end

	local firstLetter = query:sub(1, 1)
	local bucket = dict[firstLetter]
	local found = {}

	-- ONLY show words that START with the query
	if bucket then
		local seen = {}
		for _, word in ipairs(bucket) do
			if word:sub(1, #query) == query and not seen[word] then
				seen[word] = true
				table.insert(found, word)
			end
		end
	end

	table.sort(found, function(a, b) return a < b end)

	if #found == 0 then
		resultFrame.Visible = true
		resultDragBar.Text = "Tidak ditemukan"
		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(1,-8,0,28)
		lbl.BackgroundTransparency = 1
		lbl.TextColor3 = Color3.fromRGB(200,80,80)
		lbl.Font = Enum.Font.Gotham
		lbl.TextSize = 13
		lbl.Text = "[Error] Kata tidak ditemukan."
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.Parent = scrollFrame
		return
	end

	resultDragBar.Text = "'" .. query .. "'  —  " .. #found .. " kata"
	resultFrame.Visible = true

	for i, word in ipairs(found) do
		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(1,-8,0,26)
		lbl.BackgroundColor3 = Color3.fromRGB(32,32,50)
		lbl.TextColor3 = Color3.fromRGB(210,210,255)
		lbl.Font = Enum.Font.Gotham
		lbl.TextSize = 13
		lbl.Text = "  " .. i .. ".  " .. word:sub(1,1):upper() .. word:sub(2)
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.BorderSizePixel = 0
		lbl.LayoutOrder = i
		lbl.Parent = scrollFrame
		Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 5)
	end
end

-- Live update on every keystroke
textBox:GetPropertyChangedSignal("Text"):Connect(function()
	showWords(textBox.Text)
end)
