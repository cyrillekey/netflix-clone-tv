import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:netflix/models/item_model.dart";
import "package:netflix/views/widget/card_movie.dart";

class SectionHome extends StatelessWidget {
  const SectionHome({super.key, required this.data, required this.title});
  final List<ItemModel> data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Focus(
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: Get.width,
                height: Get.height * 0.40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) =>
                      CardMovie(movie: data[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
