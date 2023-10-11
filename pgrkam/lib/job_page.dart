import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pgrkam/bottom_nav.dart';
import 'package:text_scroll/text_scroll.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key});

  @override
  State<JobPage> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<JobPage> {
  String locValue = '', typeValue = '', expValue = '', qualValue = '';
  List<Map<String,dynamic>>jobs = [];
  List<String> location = [
    'Mumbai',
    'Ahmedabad',
    'Jaipur',
    'Chandigarh',
    'Bengaluru',
    'Kolkata',
    'Delhi',
    'Hyderabad',
    'Chennai',
    'Pune'
  ];
  List<String> type = ['Freelance', 'Internship', 'Full-Time', 'Part-Time'];
  List<String> qualification = [
    'High School Diploma',
    'Master\'s Degree',
    'PhD',
    'Bachelor\'s Degree',
    'Certification'
  ];
  List<String> experience = [
    'Entry Level',
    '1-3 years',
    '3-5 years',
    '5-7 years',
    '7+ years'
  ];
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/images/icon.png'),
          title: const Column(
            children: [
              Text(
                'PUNJAB GHAR GHAR ROZGAR',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Divider(
                height: 2,
                color: Colors.transparent,
              ),
              Text(
                'Department of Employee Generation, Skill\nDevelopment & Training - Govt. Of Punjab, India',
                maxLines: 2,
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber[50],
                shape: const CircleBorder(),
              ),
              child: Icon(Icons.person, color: Colors.amber[600]),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                alignment: const Alignment(0, 0),
                height: 45,
                color: Colors.green,
                child: const TextScroll(
                  'Department of Employee Generation  Recruitment Update!!  Click Here to know more! \t\t',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Divider(
                color: Colors.transparent,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.amber)),
                width: MediaQuery.of(context).size.width * 0.94,
                padding: const EdgeInsets.fromLTRB(12, 20, 20, 12),
                child: Column(
                  children: [
                    const Text(
                      'Quick Job Search',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
        
                    //Location
                    const Divider(color: Colors.transparent),
                    Container(
                      color: Colors.white,
                      child: DropdownMenu(
                        label: const Text('Select Location'),
                        width: MediaQuery.of(context).size.width * 0.88,
                        dropdownMenuEntries: location.map((String item) {
                          return DropdownMenuEntry(
                            value: item,
                            label: item,
                          );
                        }).toList(),
                        onSelected: (value) {
                          setState(() {
                            locValue = value!;
                          });
                        },
                      ),
                    ),
        
                    //Job Type
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Container(
                      color: Colors.white,
                      child: DropdownMenu(
                        label: const Text('Select Job Type'),
                        width: MediaQuery.of(context).size.width * 0.88,
                        dropdownMenuEntries: type.map((String item) {
                          return DropdownMenuEntry(value: item, label: item);
                        }).toList(),
                        onSelected: (value) {
                          setState(() {
                            typeValue = value!;
                          });
                        },
                      ),
                    ),
                    const Divider(color: Colors.transparent),
        
                    Row(
                      children: [
                        //Qualification
                        Container(
                          color: Colors.white,
                          child: DropdownMenu(
                            width: MediaQuery.of(context).size.width * 0.43,
                            label: const Text(
                              'Select Qualification',
                              style: TextStyle(fontSize: 15),
                            ),
                            dropdownMenuEntries: qualification.map((item) {
                              return DropdownMenuEntry(value: item, label: item);
                            }).toList(),
                            onSelected: (value) {
                              setState(() {
                                qualValue = value!;
                              });
                            },
                          ),
                        ),
                        const VerticalDivider(
                          width: 12,
                        ),
        
                        //Experience
                        Container(
                          color: Colors.white,
                          child: DropdownMenu(
                            width: MediaQuery.of(context).size.width * 0.37,
                            label: const Text(
                              'Experience in years',
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                            dropdownMenuEntries: experience.map((String item) {
                              return DropdownMenuEntry(value: item, label: item);
                            }).toList(),
                            onSelected: (value) {
                              setState(() {
                                expValue = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    TextButton(
                      onPressed: () async {
                        jobs.clear();
                        if (locValue == '' || typeValue == '' || qualValue == '' || expValue == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Select all fields!!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          final db = FirebaseFirestore.instance;
                          final userdata = await db
                              .collection("Jobs")
                              .where("Experience", isEqualTo: expValue)
                              .where('JobType', isEqualTo: typeValue)
                              .where('Qualification', isEqualTo: qualValue)
                              .where('Location', isEqualTo: locValue)
                              .get();
        
                          var data = userdata.docs.map((e) {
                            return e.data();
                          }).toList();
        
                          for (var job in data) {
                            jobs.add(job);
                          }
                        }
                        setState(() {
                          show = true;
                        });
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        '\tSearch Jobs\t',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.transparent,),
              show ? Column(
                      children:[ 
                        Text("Available Jobs",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        jobs.isNotEmpty ? Container(
                          height: 200,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: jobs.length,
                            itemBuilder: (context,index){
                              return ListTile(
                                subtitle: Text('Role: ' + jobs[index]['JobTitle'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300)),
                                title: Text('Company: ' + jobs[index]['Company'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              );
                          }),
                        ):Text('No Jobs Available',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                      ]
                    ) : SizedBox(),
                
                ],
          ),
        ),
        
        bottomNavigationBar: AppBottomNav(),
      ),
    );
  }
  
}