import 'package:flutter/material.dart';
import 'package:major_benchmark_app/model/component_model.dart';
import 'package:major_benchmark_app/network_util/network_util.dart';
import 'package:major_benchmark_app/pages/component_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _buildDrawerItem(String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComponentListingPage(
              title: title,
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getAllValues();
  }

  var selectedRam;
  var selectedCPU;
  var selectedSSD;
  var selectGPU;
  bool showResults = false;

  List<Component> ramList = [];
  List<Component> cpuList = [];
  List<Component> gpuList = [];
  List<Component> ssdlist = [];

  getAllValues() async {
    cpuList = await NetworkUtil().getData("cpu_lists");
    gpuList = await NetworkUtil().getData("gpu_lists");
    ramList = await NetworkUtil().getData("ram_lists");
    ssdlist = await NetworkUtil().getData("ssd_lists");

    setState(() {});
  }

  int calculateBenchMarks() {
    try {
      return ((double.parse(selectGPU?.benchmark) +
                  double.parse(selectedCPU?.benchmark) +
                  double.parse(selectedRam?.benchmark) +
                  double.parse(selectedSSD?.benchmark)) /
              150)
          .ceil();
    } catch (e) {
      return 0;
    }
  }

  List<Widget> pcResults() {
    print(calculateBenchMarks());
    return [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          "Here's How Your PC will perform",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const Text(
        "Performance :",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 20,
      ),
      Table(
        border: TableBorder.all(),
        children: [
          const TableRow(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Game",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("FPS at 1080p",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("FPS at 1440p",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("FPS at 4K",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ]),
          buildGameRow(1),
          buildGameRow(2),
          buildGameRow(3),
          buildGameRow(4),
          buildGameRow(5),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      const Text(
        "Productivity :",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 20,
      ),
      Table(
        border: TableBorder.all(),
        children: [
          const TableRow(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Software",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Runs Smoothly?",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ]),
          TableRow(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("After Effects",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: calculateBenchMarks() > 3
                    ? const Icon(Icons.check)
                    : const Icon(Icons.close)),
          ]),
          TableRow(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Photoshop",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: calculateBenchMarks() > 2
                    ? const Icon(Icons.check)
                    : const Icon(Icons.close)),
          ]),
          TableRow(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Illustrator",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: calculateBenchMarks() > 2
                    ? const Icon(Icons.check)
                    : const Icon(Icons.close)),
          ]),
          TableRow(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Premier Pro",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: calculateBenchMarks() > 4
                    ? const Icon(Icons.check)
                    : const Icon(Icons.close)),
          ]),
        ],
      )
    ];
  }

  int calculateFps(int gameID, int frameRate) {
    switch (gameID) {
      case 1:
        if (frameRate == 1080) {
          return (25.76 * calculateBenchMarks()).ceil();
        } else if (frameRate == 1440) {
          return (18.98 * calculateBenchMarks()).ceil();
        } else if (frameRate == 4080) {
          return (9.6 * calculateBenchMarks()).ceil();
        }
        return 0;
      case 2:
        if (frameRate == 1080) {
          return (23.3 * calculateBenchMarks()).ceil();
        } else if (frameRate == 1440) {
          return (16.98 * calculateBenchMarks()).ceil();
        } else if (frameRate == 4080) {
          return (8.6 * calculateBenchMarks()).ceil();
        }
        return 0;
      case 3:
        if (frameRate == 1080) {
          return (23.76 * calculateBenchMarks()).ceil();
        } else if (frameRate == 1440) {
          return (17.98 * calculateBenchMarks()).ceil();
        } else if (frameRate == 4080) {
          return (10.2 * calculateBenchMarks()).ceil();
        }
        return 0;
      case 4:
        if (frameRate == 1080) {
          return (28.76 * calculateBenchMarks()).ceil();
        } else if (frameRate == 1440) {
          return (23.98 * calculateBenchMarks()).ceil();
        } else if (frameRate == 4080) {
          return (12.6 * calculateBenchMarks()).ceil();
        }
        return 0;
      case 5:
        if (frameRate == 1080) {
          return (29.76 * calculateBenchMarks()).ceil();
        } else if (frameRate == 1440) {
          return (22.98 * calculateBenchMarks()).ceil();
        } else if (frameRate == 4080) {
          return (15.6 * calculateBenchMarks()).ceil();
        }
        return 0;
      default:
        return 0;
    }
  }

  String getGameName(int gameID) {
    switch (gameID) {
      case 1:
        return "GTA V";
      case 2:
        return "Tomb Raider";
      case 3:
        return "PubG";
      case 4:
        return "Forza Horizon";
      case 5:
        return "Battlefield V";
    }
    return "";
  }

  TableRow buildGameRow(int gameID) {
    int frameRateAt1080 = calculateFps(gameID, 1080);
    int frameRateAt1440 = calculateFps(gameID, 1440);
    int frameRateAt4k = calculateFps(gameID, 4080);

    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          getGameName(gameID),
          // style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          frameRateAt1080.toString(),
          // style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          frameRateAt1440.toString(),
          // style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          frameRateAt4k.toString(),
          // style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Bench Markers"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 100,
              color: Colors.deepPurple,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(20),
              child: const Text(
                "BenchMarkers",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDrawerItem(
              "CPU Lists",
            ),
            _buildDrawerItem(
              "GPU Lists",
            ),
            _buildDrawerItem(
              "RAM Lists",
            ),
            _buildDrawerItem(
              "SSD Lists",
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Text(
                  "Build You Custom PC!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              DropdownButton(
                  hint: const Text("Select CPU"),
                  value: selectedCPU,
                  isExpanded: true,
                  items: cpuList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.model ?? ""),
                          ))
                      .toList(),
                  onChanged: (_) {
                    setState(() {
                      selectedCPU = _;
                      showResults = false;
                    });
                  }),
              DropdownButton(
                  hint: const Text("Select SSD"),
                  value: selectedSSD,
                  isExpanded: true,
                  items: ssdlist
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.model ?? ""),
                          ))
                      .toList(),
                  onChanged: (_) {
                    setState(() {
                      selectedSSD = _;
                      showResults = false;
                    });
                  }),
              SizedBox(
                child: DropdownButton(
                    hint: const Text("Select GPU"),
                    value: selectGPU,
                    isExpanded: true,
                    items: gpuList
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.model ?? "",
                                maxLines: 1,
                              ),
                            ))
                        .toList(),
                    onChanged: (_) {
                      setState(() {
                        selectGPU = _;
                        showResults = false;
                      });
                    }),
              ),
              DropdownButton(
                  hint: const Text("Select RAM"),
                  value: selectedRam,
                  isExpanded: true,
                  items: ramList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.model ?? ""),
                          ))
                      .toList(),
                  onChanged: (_) {
                    setState(() {
                      selectedRam = _;
                      showResults = false;
                    });
                  }),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.deepPurple,
                minWidth: double.maxFinite,
                colorBrightness: Brightness.dark,
                onPressed: () {
                  setState(() {
                    showResults = true;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Build My PC!",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              if (selectGPU != null &&
                  selectedCPU != null &&
                  selectedRam != null &&
                  selectedSSD != null &&
                  showResults)
                ...pcResults(),
            ],
          ),
        ),
      ),
    );
  }
}
