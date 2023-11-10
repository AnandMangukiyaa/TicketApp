part of 'pages.dart';

class AddTicketPage extends StatefulWidget {
  const AddTicketPage({super.key});

  @override
  State<AddTicketPage> createState() => _AddTicketPageState();
}

class _AddTicketPageState extends State<AddTicketPage> {

  TextEditingController _problemTitle = TextEditingController();
  TextEditingController _problemDescription = TextEditingController();
  TextEditingController _location = TextEditingController();
  File? _file;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,ref,child) {
        bool loading  = ref.watch(ticketViewModelProvider);
        return Scaffold(
          appBar: AppBars.backAppBar(context, title: "Raise Ticket"),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Sizes.s16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    PrimaryTextField(labelText: "Problem Title", controller: _problemTitle,labelColor: Colors.black,validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please Enter Title';
                      }
                      return null;
                    },),
                    const SizedBox(height: 20,),
                    PrimaryTextField(labelText: "Problem Description", controller: _problemDescription,labelColor: Colors.black,maxLine: 5,minLine: 3,validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please Enter Description';
                      }
                      return null;
                    },),
                    const SizedBox(height: 20,),
                    PrimaryTextField(labelText: "Location", controller: _location,labelColor: Colors.black,validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please Enter Location';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20,),
                    _buildTicketAttachment(_file?.path),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w,vertical: Sizes.s8.h),
            child: PrimaryButton(label: 'Add',isLoading: loading, onPressed: () async{
                if(_formKey.currentState!.validate() && _file != null) {
                  Ticket ticket = Ticket()
                  ..problemTitle = _problemTitle.text.toString()
                  ..problemDescription = _problemDescription.text.toString()
                  ..location = _location.text.toString();
                  bool result = await ref.read(ticketViewModelProvider.notifier).addTicket(
                      ticket, _file!);
                  if(result){
                    Navigator.pop(context);
                    SnackUtils.showSnak("Ticket Added");
                  }
                }else if(_file == null){
                  SnackUtils.showSnak('Please Select Image');
                }
            },),
          ),
        );
      }
    );
  }

  Widget _buildTicketAttachment(String? imageUrl) {
    return SizedBox(
      height: ScreenUtil().setHeight(300),
      width: ScreenUtil().screenWidth - 32,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: WidgetDelegate(
              shouldShowPrimary: _file != null,
              primaryWidget: () {
                return GestureDetector(
                  onTap: _pickImageHandler,
                  child: Container(
                    height: Sizes.s300.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.secondary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(Sizes.s10.sp),
                      image: DecorationImage(image: FileImage(_file!),fit: BoxFit.contain),
                    ),
                  ),
                );
              },
              alternateWidget: () {
                return WidgetDelegate(
                  shouldShowPrimary: imageUrl != null,
                  primaryWidget: () {
                    return Image.network(
                      imageUrl ?? '',
                      height: Sizes.s300.h,
                    );
                  },
                  alternateWidget: () {
                    return Container(
                      height: Sizes.s300.h,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(Sizes.s10.sp),
                        color: AppColors.secondary.withOpacity(0.05),
                      ),

                    );
                  },
                );
              },
            ),
          ),
          _file == null ? Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: _pickImageHandler,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  size: Sizes.s24.h,
                  color: Colors.white,
                ),
              ),
            ),
          ):SizedBox.shrink(),
        ],
      ),
    );
  }

  void _pickImageHandler() async {
    File? file = await AppDialogs.showImageSourceSheet(context);
    if (file != null) {
      setState(() {
        _file = file;
      });
    }
  }
}
