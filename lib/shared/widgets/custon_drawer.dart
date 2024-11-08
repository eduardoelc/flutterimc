import 'package:flutter/material.dart';

class CustonDrawer extends StatelessWidget {
  const CustonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        padding: EdgeInsets.zero,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  context: context,
                  builder: (BuildContext bc) {
                    return Wrap(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Camera"),
                          leading: const Icon(Icons.camera),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Galeria"),
                          leading: const Icon(Icons.image_outlined),
                        )
                      ],
                    );
                  });
            },
            child: const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25.0,
                  foregroundImage: NetworkImage(
                      "https://lh3.googleusercontent.com/a-/ALV-UjXpkYtscsuqHvBpxTCHQl26eqoRBdKJa4GXNpsCazzFZmJfsdrHHa-IOGRhbE2uFVOzxrFxe2097FdRZbuaVg3f95al079bq0Cfl9zOZ_3fo_XoVfmIEwL0APB1ikhlJP4V1dCLNictwGAZHdN92RuCWwjOndg1HcdLdlNwtxUqB_0KdLERO6nlpvrlI6SRSY5QcG_UhaxS-ymIwkXX7ijQl9SG99j9HOHg5g_at4Sn92_aqa_SIgNaA9o1uCO1taKPcxFh7GAO5soqPVr5cxk0UF0lQD-bj87MqOLMJQuNn7XxldvkHqPb1StuSXpOT-2B4aRAd36VwLBF-TAeK9WcTD7d9Acu1dEz6PSHMG5oQHxlG68fkbUAC7SFeK2AcPfoX5-k5Jm_lWIY6Lk4SGSV1uOrYyp3ol_RjLpcKu_pfNFDXx9maklnTkOm6gAZh5L_ieyuEORLLGzrdGjOheYxZzA32P_x52ra9Giw7i5Q0DiFoyMErZaSIkXiSk3M8pZwBROXJUjjNWRG51Leve5laFXfLJ-nxCnY32quDCdgsbZPXfu59EZQUoe-WGNtnIGvgZapDYi9mvTyi6159ElA33UvefznRjQd4nSE4UHI6bIFIFAK4OfsC_vX_uBH8KEgSY5dnnedpRcyGB6uGbkk6bZ8OsYwzLNHhr-oIyQiG1-lLIRKNymH8OqtpQgaNA1N0tBOJa5RPseHq13HTmCOtbLfM87e1Q1O01s3x2dFQDm4BX4n1YKqs9WXy8vHhoemHkCOSRyhAd10SICtjD8W-1P9abjWwd6m8VrQnjfnAaeJTpPI8BDXiInrrbOx36pCm0W-xNgbftXOw_C1rw4HR9VF7jibBRMX-lqeom1ZRmduxxxFLohkUE41ClskevASN7Ufbefb2YOB_8_RygZMqISSXSKoMYXThX9nmOgTORId7J0WRY0Ef5rrM4-Hi5683AVhERlesh0LuYgPtkcfrp7J=s360-c-no"),
                ),
                accountName: Text("Email"),
                accountEmail: Text("Email@email.com")),
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Dados Pessoais"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             const DadosCadastraisSharedPreferencesPage()));
            },
          ),
        ],
      ),
    );
  }
}
