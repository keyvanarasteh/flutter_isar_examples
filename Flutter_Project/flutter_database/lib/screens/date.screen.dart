import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DateScreen extends StatefulWidget {
  const DateScreen({super.key});

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Text(
              "Hocam tarih ve chart  için kullandığımız paketleri yüklediğimde hata alıyorum 4,5 saat uğraştım ama çözemedim. İnternette araştırdım ve yaptım söyleneni ama işe yaramadı. Size sorucaktım ama haftasonu ve az kaldığı için dönmeniz geç olur diye düşündüm. Haftaiçide diğer okul sınavları oldğu için bakamadım. Yinede hata versede yorum satırı olarak kodları yazmaya çalıştım. Ama hata altıgım için database ile baglayamadım")),

      /*
      Örnek Tarih Kodu:
              SfDateRangePicker(
                backgroundColor: Colors.grey,
                selectionMode: DateRangePickerSelectionMode.range,
                showActionButtons: true,
                onSelectionChanged: (e) {
                  if(e.value is PickerDateRange)
                  {
                    final DateTime rangeStartDate = e.value.startDate;
                    final DateTime? rangeEndDate = e.value.endDate;
                  }
                }

              )
              */
    );
  }
}
