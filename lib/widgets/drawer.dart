import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        "https://lh3.googleusercontent.com/a/ACg8ocL4xe6zW0VykBtj6R2wKDVt2Ki9xIn6tSFlfSJSYCFLJA=s288-c-no";
    return Drawer(
      child: Container(
        color: Colors.deepPurple,
        child: ListView(
          children: [
            DrawerHeader(
                /*
               EdgeInsets là một lớp được sử dụng để đại diện cho các kích thước 
               của đường biên (margin) và đệm (padding) xung quanh một widge
              */
                //tất cả các phần tử (top, right, bottom, left) đều có giá trị zero,
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                    margin: EdgeInsets.zero,
                    accountName: const Text('Toan Nguyen'),
                    accountEmail: const Text('toan@gmail.com'),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                    )
                    //Image.network(imageUrl), => chỉ show ra ô vuông hình của gmail
                    )),
                    //tạo ra các item trên thanh trượt
            const ListTile(
              //Biểu tượng hiện trước => thường là item
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.2,
              ),
             
            ),
            const ListTile(
              leading: Icon(
                CupertinoIcons.mail,
                color: Colors.white,
              ),
              title: Text(
                'Email',
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text(
                'My profile',
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
