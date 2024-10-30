import 'package:flutter/material.dart';
import 'package:map_prac/utils/db_helpers.dart';
import 'package:intl/intl.dart';

class SearchScreenHistory extends StatelessWidget {
  const SearchScreenHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var historyList = DbHelpers.getAllHistory();
    historyList.sort((a, b) => (b['id'] as int).compareTo(a['id'] as int));

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          var item = historyList[index];
          var results = item['results'] as List? ?? [].map((e)=> Map<String, dynamic>.from(e)).toList();
          var clicked = item['clicked'];

          return ListTile(
            title: Text(item['query']),
            trailing: Text("${results.length} results"),
            subtitle: Text(DateFormat("dd MMM - hh:mm")
                .format(DateTime.fromMillisecondsSinceEpoch(item['id']))),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("${results.length} Results"),
                  content: SingleChildScrollView(
                    child: Column(
                      children: results
                          .map(
                            (e) => ListTile(
                              title:
                                  Text("${e['latitude']}, ${e['longitude']}"),
                              trailing: (clicked['latitude'] == e['latitude'] &&
                                      clicked['longitude'] == e['longitude'])
                                  ? const Icon(Icons.check)
                                  : null,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              );
            },
          );
        },
        itemCount: historyList.length,
      ),
    );
  }
}
