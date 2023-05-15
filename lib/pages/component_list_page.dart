import 'package:flutter/material.dart';
import 'package:major_benchmark_app/model/component_model.dart';
import 'package:major_benchmark_app/network_util/network_util.dart';
import 'package:url_launcher/url_launcher.dart';

class ComponentListingPage extends StatefulWidget {
  final String title;
  //final List<Component> componentList;

  const ComponentListingPage({super.key, required this.title});

  @override
  State<ComponentListingPage> createState() => _ComponentListingPageState();
}

class _ComponentListingPageState extends State<ComponentListingPage> {
  NetworkUtil networkUtil = NetworkUtil();

  List<Component>? componentList;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    componentList = await networkUtil.getData(getCollectionName(widget.title));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Map brandLogos = {
      "nvidia": {
        "color": Colors.black,
        "imgColor": null,
        "url":
            "https://www.nvidia.com/content/dam/en-zz/Solutions/about-nvidia/logo-and-brand/01-nvidia-logo-horiz-500x200-2c50-d@2x.png"
      },
      "amd": {
        "color": Colors.black,
        "imgColor": Colors.white,
        "url":
            "https://d1ra4hr810e003.cloudfront.net/visual/accountlogo/6D972F55-8581-42E9-B19004B4B9C6882E/medium-C96D16F7-8CB9-4345-B9D2F1923BCDFA0E.png"
      },
      "intel": {
        "color": Colors.blue,
        "imgColor": Colors.white,
        "url":
            "https://1000logos.net/wp-content/uploads/2021/05/Intel-logo-1536x864.png"
      },
      "asus": {
        "color": Colors.black,
        "imgColor": Colors.white,
        "url":
            "https://logos-world.net/wp-content/uploads/2020/07/Asus-Logo.png"
      },
      "msi": {
        "color": Colors.red,
        "imgColor": Colors.white,
        "url":
            "https://storage-asset.msi.com/event/msi-logos/images/msi-logo_w.png"
      },
      "samsung": {
        "color": Colors.black,
        "imgColor": null,
        "url":
            "https://images.samsung.com/is/image/samsung/assets/in/about-us/brand/logo/pc/720_600_1.png"
      },
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple.shade500,
      ),
      body: componentList == null
          ? const Center(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: componentList?.length,
              itemBuilder: (BuildContext context, int index) {
                var brand =
                    brandLogos[componentList![index].brand?.toLowerCase()];
                return Container(
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: brand == null
                              ? Colors.transparent
                              : brand["color"],
                          width: 100,
                          height: 70,
                          alignment: Alignment.center,
                          child: Image.network(
                            brand == null
                                ? "https://feelforhair.co.uk/wp-content/uploads/2017/12/default-post-thumbnail.png"
                                : brand["url"] ?? "",
                            fit: BoxFit.fill,
                            color: brand == null ? null : brand["imgColor"],
                            height: 100,
                            width: double.maxFinite,
                            errorBuilder: (context, error, stackTrace) {
                              return Container();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            componentList![index].model ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                            color: Colors.black,
                            onPressed: () {
                              launchUrl(
                                  Uri.parse(componentList![index].uRL ?? ""));
                            },
                            icon: const Icon(Icons.info_outline)),
                        IconButton(
                            color: Colors.black,
                            onPressed: () {
                              String url =
                                  "https://www.amazon.in/s?k=${componentList![index].model}";
                              launchUrl(Uri.parse(url));
                            },
                            icon: const Icon(Icons.shopping_bag_outlined)),
                      ]),
                );
              },
            ),
    );
  }
}

String getCollectionName(String title) {
  switch (title) {
    case "CPU Lists":
      return "cpu_lists";
    case "GPU Lists":
      return "gpu_lists";
    case "RAM Lists":
      return "ram_lists";
    case "SSD Lists":
      return "ssd_lists";
    default:
      return "cpu_lists";
  }
}
