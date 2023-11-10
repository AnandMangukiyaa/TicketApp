part of 'pages.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Consumer(
      builder: (context,ref,child) {

        return Scaffold(
          appBar: AppBars.homeAppBar(context, title: widget.title),
          body: StreamBuilder<List<Ticket>>(
            stream: ref.read(ticketViewModelProvider.notifier).getTickets(),
            builder: (context, snapshot) {
              if(snapshot.hasData ) {
                if(snapshot.data!.isNotEmpty) {
                  return Padding(
                    padding:  EdgeInsets.all(Sizes.s16.w),
                    child: SizedBox(
                      child: ListView.separated(
                          itemBuilder: (context,index) {
                            return Card(
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: Sizes.s150.h,
                                    width:  Sizes.s100.w,
                                    child: Image.network(snapshot.data![index].storedImage!),
                                  ),
                                  SizedBox(width: Sizes.s16.w,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data![index].problemTitle!,style: TextStyle(fontSize: Sizes.s16.sp,color: Colors.black,fontWeight: FontWeight.w600),),
                                      SizedBox(height: Sizes.s8.h,),
                                      Text(snapshot.data![index].problemDescription!,style: TextStyle(fontSize: Sizes.s14.sp,color: Colors.grey,fontWeight: FontWeight.w500),),
                                      SizedBox(height: Sizes.s8.h,),
                                      Text(snapshot.data![index].location!,style: TextStyle(fontSize: Sizes.s14.sp,color: Colors.grey,fontWeight: FontWeight.w500),),
                                      SizedBox(height: Sizes.s8.h,),
                                      Text(DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.parse(snapshot.data![index].createdAt!)),style: TextStyle(fontSize: Sizes.s14.sp,color: Colors.grey,fontWeight: FontWeight.w500),),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context,index) {
                            return SizedBox(height: Sizes.s8.h,);
                          },
                          itemCount: snapshot.data!.length),
                    ),
                  );
                }else{
                  return Center(
                    child: Text('No tickets found!',style: TextStyle(fontSize: Sizes.s20.sp,fontWeight: FontWeight.w600,color: Colors.black),),
                  );
                }
              }else{
                return Center(
                  child: CircularProgressIndicator(color: AppColors.primary,),
                );
              }
            }
          ),
          floatingActionButton: FloatingActionButton(
            onPressed:()=> Navigator.pushNamed(context, Routes.addTicket),
            tooltip: 'Increment',
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.add,color: Colors.white,),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      }
    );
  }
}