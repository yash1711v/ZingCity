import '../../router/route_packages_name.dart';

class AddScreen2 extends StatefulWidget {
  const AddScreen2({super.key});

  @override
  State<AddScreen2> createState() => _AddScreen2State();
}

class _AddScreen2State extends State<AddScreen2> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 339,
                    child: Text(
                      'Property name',
                      style: TextStyle(
                        color: Color(0xFF4D5454),
                        fontSize: 14,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                 decoration: InputDecoration(
                   hintText: 'Enter property name',
                   border: InputBorder.none,
                 ),
               ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 339,
                    child: Text(
                      'Description',
                      style: TextStyle(
                        color: Color(0xFF4D5454),
                        fontSize: 14,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Discribe your property',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 198,
                    child: Text(
                      'Address',
                      style: TextStyle(
                        color: Color(0xFF4D5454),
                        fontSize: 14,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Choose Location',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF30469A),
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      height: 0.10,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'City',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'State',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Country',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                maxLines: 7,
                decoration: InputDecoration(
                  hintText: 'Address',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
