import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:isar_project/db/book.dart';
import '../utils/utils.dart';
import 'charts_page.dart';
import 'favorite_page.dart';
import 'info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  // Bu sayfanın scroll pozisyonunu saklamak için bir ScrollController kullanın.
  final _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  getAllBooks() async {
    books = await isar.books.where().findAll();
    setState(() {});
  }

  addBook(String name, String writer, String subject, String imageBook, String imageWriter, double price, int stok) async {
    Book newBook = Book()
      ..name = name
      ..writer = writer
      ..subject = subject
      ..imageBook = imageBook
      ..imageWriter = imageWriter
      ..price = price
      ..stok = stok;
    await isar.writeTxn(() async {
      var addedId = isar.books.put(newBook);
      print(addedId);
      getAllBooks();
    });
  }

  openConnection() async {
    try {
      isar = await Isar.open([BookSchema]);
      if (isar.isOpen) {
        print("database ile bağlantı kuruldu");
        getAllBooks();
      }
      else {
        print("bağlantı hatası");
      }
    } catch (e) {
      print("open hatası oluştu:");
      print(e);
    }
  }

  closeConnection() async {
    try {
      var result = await isar.close();
      if (result) {
        print("bağlantı başarıyla kapatıldı");
      }
      else {
        print("bağlantı kapatılamadı");
      }
    } catch (e) {
      print("close hatası oluştu:");
      print(e);
    }
  }

  @override
  void initState() {
    openConnection();
    super.initState();
  }

  @override
  void dispose() {
    // closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitap Listesi'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_outlined),
            onPressed: () async {
                addBook(
                  "Nutuk", 
                  "Mustafa Kemal Atatürk",
                  '''Ey Türk gençliği!\n\nBirinci görevin, Türk bağımsızlığını, Türk Cumhuriyeti’ni sonsuza kadar korumak ve savunmaktır. Varlığının ve geleceğinin tek temeli budur. Bu temel, senin en değerli hazinendir. Gelecekte de, seni bu hazineden yoksun bırakmak isteyecek iç ve dış düşmanların olacaktır. Bir gün, bağımsızlık ve cumhuriyeti savunma zorunluluğuna düşersen, göreve atılmak için, içinde bulunacağın durumun olanak ve koşullarını düşünmeyeceksin! Bu olanak ve koşullar çok elverişsiz bir nitelikte görünebilir. Bağımsızlık ve cumhuriyetine kastedecek düşmanlar, bütün dünyada benzeri görülmemiş bir zaferin temsilcisi olabilirler. Zorla ve aldatmacayla sevgili vatanın bütün kaleleri zaptedilmiş, bütün tersanelerine girilmiş, bütün orduları dağıtılmış ve ülkenin her köşesi fiili olarak ele geçirilmiş olabilir. Bütün bu koşullardan daha acıklı ve daha korkunç olmak üzere, ülkenin içinde iktidara sahip olanlar aymazlık ve sapkınlık ve hatta hainlik içinde bulunabilirler. Hatta bu iktidar sahipleri, kişisel çıkarlarını istilacıların siyasi emelleriyle birleştirebilirler. Ulus, yoksulluk ve sıkıntı içinde yorgun ve bitkin düşmüş olabilir.\n\nEy Türk geleceğinin evladı!\n\nİşte, bu durum ve koşullar içinde bile görevin, Türk bağımsızlık ve cumhuriyetini kurtarmaktır! Muhtaç olduğun güç, damarlarındaki soylu kanda mevcuttur!''',
                  "https://www.iskultur.com.tr/dosyalar/2010/02/nutuk-8.png",
                  "https://cdnuploads.aa.com.tr/uploads/Contents/2020/11/09/thumbs_b_c_667360298277a3240ae508e5bb63f60d.jpg",
                  25, 
                  10,
                );
                addBook(
                  "Körlük", 
                  "Jose Saramago", 
                  '''Adı bilinmeyen bir ülkenin adı bilinmeyen bir kentinde, arabasının direksiyonunda trafik ışığının yeşile dönmesini bekleyen bir adam ansızın kör olur. Ancak karanlıklara değil, bembeyaz bir boşluğa gömülür. Arkasından, körlük salgını bütün kente, hatta bütün ülkeye yayılır. Ne yönetim kalır ülkede, ne de düzen; bütün körler karantinaya alınır. Hayal bile edilemeyecek bir kaos, pislik, açlık ve zorbalık hüküm sürmektedir artık. Yaşam durmuştur, insanların tek çabası, ne pahasına olursa olsun hayatta kalmaktır. Roman, kentteki akıl hastanesinde karantinaya alınan, oradan kurtulunca da birbirinden ayrılmayan, biri çocuk yedi kişiye odaklanır. Aralarında, bütün kentte gözleri gören tek kişi olan ve gruptakilere rehberlik eden bir kadın da vardır. Bu yedi kişi, cehenneme dönen bu kentte, hayatta kalabilmek için inanılmaz bir mücadele verir. Saramago’nun müthiş bir gözlem gücüyle betimlediği bu kaotik dünya, insanın karanlık yüzünün simgesi.\n\nKörlük, ürkütücü bir roman, beklenmedik bir felaketi yaşayan bir toplumun nasıl çöktüğünün, nasıl bencilleştiğinin ve değer yargılarını yitirdiğinin hikâyesi. Konusunun ürkütücülüğüne rağmen olağanüstü bir şiirsellikle anlatılmış bu unutulmaz roman, usta yazarın belki de en etkileyici yapıtı.''', 
                  "https://static.nadirkitap.com/fotograf/210366/30/Kitap_202301201041242103669.jpg", 
                  "https://images.aposto.com/2022/6/6/1658569808696.jpeg", 
                  35, 
                  5,
                );
                addBook(
                  "Suç ve Ceza", 
                  "Dostoyevski", 
                  '''Dostoyevski (1821-1881): Gerek 1840 ortalarından itibaren yayımlamaya başladığı Beyaz Geceler ve Öteki gibi uzun öykü-kısa romanlarıyla, gerekse ilkini elinizde tuttuğunuz Suç ve Ceza, Budala ve Karamazov Kardeşler gibi Sibirya sürgünü sonrası büyük romanlarıyla Dostoyevski, insanın karanlık yakasını kendinden sonraki bütün romancıları derinden etkileyecek biçimde dile getirmiş büyük bir 19. yüzyıl ustasıdır.\n\nMazlum Beyhan (1944); Yayımlamış olduğu Dostoyevski’den Suç ve Ceza ve Budala, Tolstoy’dan Çocukluğum, İlkgençliğim, Gençliğim ve Gogol’dan Arabeskler benzeri çalışmalar düşünüldüğünde, Beyhan, hiç tartışmasız son 35 yılın en önemli Rus edebiyatı çevirmenlerinden biridir.''', 
                  "https://www.iskultur.com.tr/dosyalar/2006/11/SUC-VE-CEZA-5.png",
                  "https://www.indyturk.com/sites/default/files/styles/1368x911/public/article/main_image/2022/03/02/877551-616040313.jpg",
                  50, 
                  7,
                );
                addBook(
                  "Altıncı Koğuş", 
                  "Anton Çehov", 
                  '''Çehov bir taşra kasabasındaki akıl hastanesinde geçen bu novellasında, eğitimli bir hasta olan İvan Dmitriç ile Doktor Andrey Yefimıç arasındaki felsefi çatışmaya odaklanır. İvan Dmitriç maruz kaldıkları adaletsizliğe, içinde yaşamaya zorlandıkları berbat koşullara karşı çıkarken, Andrey Yefimıç bunları görmezden gelmekte ısrar eder ve durumu değiştirmek için kılını bile kıpırdatmaz. Doktor sonunda içine düştüğü “felsefi” yanılgının farkına vardığında ise artık iş işten geçmiştir. Altıncı Koğuş, Rusya’nın ve ülkenin sorunlarıyla ilgilenmek yerine onları uzaktan izlemeyi tercih eden elit Rus aydınının “deliliği”nin simgesidir adeta. Altıncı Koğuş, Russkaya Mısl dergisinin 1892 kasım sayısında yayımlandığında büyük ilgi görmüştü. Hatta Lenin’in de yapıtı okuduktan sonra dehşete kapıldığı, “Kendimi Alıncı Koğuş’a kapatılmış gibi hissettim” dediği rivayet edilir. ANTON PAVLOVİÇ ÇEHOV (1860-1904): Büyük Rus tiyatro yazarı ve modern öykünün en önemli ustalarından olan Çehov, Rus Gerçekçilik okulunun önde gelen temsilcisidir. Taganrog’da dünyaya geldi. Lisede Yunan ve Latin klasiklerini temel alan bir eğitim gördü. 1879’da Moskova’ya giderek tıp fakültesine yazıldı ve 1884’te doktor oldu. Alacakaranlıkta adlı öykü kitabıyla 1887’de Rus Akademisi tarafından verilen Puşkin Ödülü’nü kazandı. Yaklaşık bin sözcükten oluşan komik kısa öykü türünü başlı başına bir sanat haline getirdi. Ancak 1888’de yayımlanan Bozkır adlı yapıtıyla komik öykülere sırt çevirmiş oldu. Önemli oyunları arasında Ayı (1888), Evlenme Teklifi (1889), Martı (1896), Vanya Dayı (1899), Üç Kız Kardeş (1900) ve Vişne Bahçesi (1903) sayılabilir.''', 
                  "https://www.iskultur.com.tr/dosyalar/2017/08/altinci-kogus-2.png",
                  "https://upload.wikimedia.org/wikipedia/commons/c/c0/Anton_Chekhov_with_bow-tie_sepia_image.jpg",
                  20, 
                  3,
                );
                addBook(
                  "Kuyucaklı Yusuf", 
                  "Sabahattin Ali", 
                  '''“Sabahattin Ali Kuyucaklı Yusuf ’ta bir Anadolu kasabasını, bütün insani ve sosyal gerçekliğiyle verir: Soylu insanlarıyla, bayağı insanlarıyla; sevgilerle, nefretlerle; umutla umutsuzlukla… (…) Okuduğum Türk romanları içinde ayrıntıların en mükemmel, en ustaca kullanıldığı romanlardan biri. O pek önemsizmiş gibi görünen küçük küçük ayrıntılar romana tam bir somutluk kazandırıyor; romandaki dünya, çerçevesini kırıp dışarıya fırlıyor, sizin dünyanıza karışıyor.” –Fethi Naci Nazilli’de başlayan ve Edremit’e taşınan bu hüzünlü roman, bir “tabiat insanı” olarak Yusuf’un kasaba eşrafı ve halk arasında giderek sertleşen güç gösterileri içinde temiz kalma, aşkını koruma, aslında var olma savaşını anlatıyor.''',
                  "https://www.iskultur.com.tr/dosyalar/2020/01/kuyucakli-yusuf.png",
                  "https://upload.wikimedia.org/wikipedia/tr/thumb/f/f6/Sabahattin_ali.jpg/260px-Sabahattin_ali.jpg",
                  30, 
                  8,
                );
                books = await isar.books.where().findAll();
                setState(() {});
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        shadowColor: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage("https://avatars.githubusercontent.com/u/16303698")
              ),
              SizedBox(height: 10),
              Divider(endIndent: 20, indent: 20, color: Colors.white),
              SizedBox(height: 10),
              Text("Merhaba Keyvan!", style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 10),
              Divider(endIndent: 20, indent: 20, color: Colors.white),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
                child: Wrap(
                  spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 1,color: Colors.white),
                      ),
                      child: Icon(Icons.home_outlined, size: 18),
                    ),
                    Text("Anasayfa", style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return FavPage();
                  }));
                },
                child: Wrap(
                  spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text("Favoriler", style: Theme.of(context).textTheme.headlineSmall),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 1,color: Colors.red),
                      ),
                      child: Icon(Icons.favorite_outline, size: 18, color: Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return ChartPage();
                  }));
                },
                child: Wrap(
                  spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 1,color: Colors.orange),
                      ),
                      child: Icon(Icons.bar_chart_outlined, size: 18, color: Colors.orange),
                    ),
                    Text("Charts", style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // body: Center(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       SizedBox(height: 10),
      //       Row(
      //         children: [
      //           SizedBox(width: 10),
      //           Text("En çok okunan yazarlar", style: Theme.of(context).textTheme.titleLarge)
      //         ],
      //       ),
      //       SizedBox(height: 10),
      //       Expanded(
      //         flex: 1,
      //         child: ListView.builder(
      //           scrollDirection: Axis.horizontal,
      //           itemCount: books.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             return Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 10),
      //               child: InkWell(
      //                 child: Hero(
      //                   tag: "writer $index",
      //                   child: ClipOval(
      //                     child: CachedNetworkImage(
      //                       imageUrl: books[index].imageWriter!,
      //                       progressIndicatorBuilder: (context, url, progress) => LinearProgressIndicator(),
      //                       errorWidget: (context, url, error) => Icon(Icons.error_outline_outlined),
      //                       fit: BoxFit.fill,
      //                       width: 60,
      //                     ),
      //                   ),
      //                 ),
      //                 onTap: () {
      //                   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                     return InfoPage(id: index, writer: true); 
      //                   }));
      //                 },
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //       SizedBox(height: 10),
      //       Row(
      //         children: [
      //           SizedBox(width: 10),
      //           Text("En son eklenenler", style: Theme.of(context).textTheme.titleLarge)
      //         ],
      //       ),
      //       SizedBox(height: 10),
      //       Expanded(
      //         flex: 3,
      //         child: ListView.builder(
      //           scrollDirection: Axis.horizontal,
      //           itemCount: books.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             return InkWell(
      //               child: Container(
      //                 margin: const EdgeInsets.all(5),
      //                 clipBehavior: Clip.hardEdge,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                 ),
      //                 child: CachedNetworkImage(
      //                   imageUrl: books[(books.length - 1) - index].imageBook!,
      //                   progressIndicatorBuilder: (context, url, progress) => LinearProgressIndicator(),
      //                   errorWidget: (context, url, error) => Icon(Icons.error_outline_outlined),
      //                   fit: BoxFit.fill,
      //                   width: 100,
      //                 ),
      //               ),
      //               onTap: () {
      //                 Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                   return InfoPage(id: (books.length - 1) - index, writer: false);
      //                 }));
      //               },
      //             );
      //           },
      //         ),
      //       ),
      //       SizedBox(height: 10),
      //       Row(
      //         children: [
      //           SizedBox(width: 10),
      //           Text("En çok satanlar", style: Theme.of(context).textTheme.titleLarge)
      //         ],
      //       ),
      //       SizedBox(height: 10),
      //       Expanded(
      //         flex: 6,
      //         child: ListView.builder(
      //           itemCount: books.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             return InkWell(
      //               child: Container(
      //                 height: 120,
      //                 margin: const EdgeInsets.all(5),
      //                 // clipBehavior: Clip.hardEdge,
      //                 decoration: BoxDecoration(
      //                   color: Colors.grey[900],
      //                   borderRadius: BorderRadius.circular(20),
      //                 ),
      //                 child: Row(
      //                   children: [
      //                     Expanded(
      //                       flex: 1,
      //                       child: Hero(
      //                         tag: "image $index",
      //                         child: ClipRRect(
      //                           borderRadius: BorderRadius.only(
      //                             topLeft: Radius.circular(20),
      //                             bottomLeft: Radius.circular(20),
      //                           ),
      //                           child: CachedNetworkImage(
      //                               imageUrl: books[index].imageBook!,
      //                               progressIndicatorBuilder: (context, url, progress) => LinearProgressIndicator(),
      //                               errorWidget: (context, url, error) => Icon(Icons.error_outline_outlined),
      //                               fit: BoxFit.fill,
      //                             ),
      //                           ),
      //                         ),
      //                     ),
      //                     Expanded(
      //                       flex: 2,
      //                       child: Column(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           Text(books[index].name!, style: Theme.of(context).textTheme.titleLarge),
      //                           SizedBox(height: 10),
      //                           Text("- ${books[index].writer!} -", style: Theme.of(context).textTheme.titleMedium),
      //                           SizedBox(height: 20),
      //                           Row(
      //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                             children: [
      //                               Text("${books[index].price!.toStringAsFixed(2)} ₺", style: Theme.of(context).textTheme.titleLarge?.copyWith(
      //                                 color: Colors.orange,
      //                               )),
      //                               Text("${(books[index].price! + 3).toStringAsFixed(2)} ₺", style: Theme.of(context).textTheme.titleMedium?.copyWith(
      //                                 decoration: TextDecoration.lineThrough,
      //                                 color: Colors.red,
      //                               )),
      //                             ],
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               onTap: () {
      //                 Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                   return InfoPage(id: index, writer: false); 
      //                 }));
      //               },
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: ListView(
        controller: _scrollController,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text("En çok okunan yazarlar", style: Theme.of(context).textTheme.titleLarge)
                ],
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: books.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        child: Hero(
                          tag: "writer ${books.indexOf(e)}",
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: e.imageWriter!,
                              progressIndicatorBuilder: (context, url, progress) => LinearProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error_outline_outlined),
                              fit: BoxFit.fill,
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return InfoPage(id: books.indexOf(e), writer: true); 
                          }));
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text("En son eklenenler", style: Theme.of(context).textTheme.titleLarge)
                ],
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: books.map((e) {
                    return InkWell(
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: books[(books.length - 1) - books.indexOf(e)].imageBook!,
                            progressIndicatorBuilder: (context, url, progress) => LinearProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error_outline_outlined),
                            fit: BoxFit.fill,
                            width: 100,
                            height: 160,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return InfoPage(id: (books.length - 1) - books.indexOf(e), writer: false);
                          }));
                        },
                      );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text("En çok satanlar", style: Theme.of(context).textTheme.titleLarge)
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: books.map((e) {
                  return InkWell(
                      child: Container(
                        height: 120,
                        margin: const EdgeInsets.all(5),
                        // clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Hero(
                                tag: "image ${books.indexOf(e)}",
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  child: CachedNetworkImage(
                                      imageUrl: e.imageBook!,
                                      progressIndicatorBuilder: (context, url, progress) => LinearProgressIndicator(),
                                      errorWidget: (context, url, error) => Icon(Icons.error_outline_outlined),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(e.name!, style: Theme.of(context).textTheme.titleLarge),
                                  SizedBox(height: 10),
                                  Text("- ${e.writer!} -", style: Theme.of(context).textTheme.titleMedium),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("${e.price!.toStringAsFixed(2)} ₺", style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: Colors.orange,
                                      )),
                                      Text("${(e.price! + 3).toStringAsFixed(2)} ₺", style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.red,
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return InfoPage(id: books.indexOf(e), writer: false); 
                        }));
                      },
                    );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}