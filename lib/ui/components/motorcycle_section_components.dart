import 'package:flutter/material.dart';

class MotorcycleItem {
  final String title;
  final String image;
  final String status;
  final String location;
  final String date;
  final String type;

  MotorcycleItem({
    required this.title,
    required this.image,
    required this.status,
    required this.location,
    required this.date,
    required this.type,
  });
}

class MotorcycleSection extends StatelessWidget {
  MotorcycleSection({Key? key}) : super(key: key);

  // Data simulasi
  final List<MotorcycleItem> motorcycles = [
    MotorcycleItem(
        title: 'Aerox 155',
        image: 'assets/motor/aerox.png',
        status: 'Penemuan',
        location: 'PII, FMIPA',
        date: '13 Agustus 2024, 10.40',
        type: 'found'),
    MotorcycleItem(
        title: 'Vario 150',
        image: 'assets/motor/vario.png',
        status: 'Kehilangan',
        location: 'Wisma Soedirman, FT',
        date: '20 September 2024, 14.40',
        type: 'lost'),
    MotorcycleItem(
        title: 'Beat Street 2021',
        image: 'assets/motor/beat.png',
        status: 'Penemuan',
        location: 'PII, FMIPA',
        date: '13 Agustus 2024, 10.40',
        type: 'found'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 45, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Motor',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0FBD2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Lainnya',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF055C0E),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: motorcycles.length,
            itemBuilder: (context, index) {
              final motorcycle = motorcycles[index];
              return Container(
                width: 220,
                margin: const EdgeInsets.only(right: 20, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            motorcycle.image,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: motorcycle.type == 'lost'
                                      ? const Color(0xFFB60000)
                                      : const Color(0xFF1B6DF4),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Text(
                                  motorcycle.status,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                motorcycle.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/loct.png',
                                    width: 14,
                                    height: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      motorcycle.location,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/calendar.png',
                                    width: 14,
                                    height: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    motorcycle.date,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: () {
                          // Tambahkan aksi
                        },
                        child: const Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
