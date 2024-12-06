import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:temulik/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:latlong2/latlong.dart';
import 'package:temulik/ui/pin_map_page.dart';

class DoneButton extends StatelessWidget {
  final VoidCallback onPressed;
  const DoneButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 20.0,
        ),
        backgroundColor: AppColors.green,
        overlayColor: AppColors.green,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
            size: 20.0,
          ),
          const SizedBox(width: 8.0),
          TextBold(
            text: 'Selesai Pengajuan Barang',
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class WhatsappButton extends StatelessWidget {
  final VoidCallback onPressed;

  const WhatsappButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 20.0,
        ),
        backgroundColor: Colors.transparent,
        overlayColor: AppColors.green,
        elevation: 0,
        side: BorderSide(
          color: AppColors.green,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/whatsapp.svg',
            colorFilter: ColorFilter.mode(
              AppColors.green,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8.0),
          TextBold(
            text: 'Kontak Bersangkutan',
            color: AppColors.green,
          ),
        ],
      ),
    );
  }
}

class TextBold extends StatelessWidget {
  final String text;
  final Color color;
  const TextBold({
    super.key,
    required this.text,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

class TextTinyMedium extends StatelessWidget {
  final String text;
  const TextTinyMedium({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: AppColors.dark,
      ),
    );
  }
}

class TextSmallMedium extends StatelessWidget {
  final String text;
  final Color color;
  const TextSmallMedium({
    super.key,
    required this.text,
    this.color = AppColors.darkest,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }
}

class TextSmallBold extends StatelessWidget {
  final String text;
  final Color color;
  const TextSmallBold({
    super.key,
    required this.text,
    this.color = AppColors.darkest,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

class CustomImageSlider extends StatefulWidget {
  final List<dynamic> imageUrls;
  final double height;
  final Duration autoPlayDuration;
  final Duration animationDuration;
  final bool autoPlay;

  const CustomImageSlider({
    Key? key,
    required this.imageUrls,
    this.height = 200.0,
    this.autoPlayDuration = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 500),
    this.autoPlay = true,
  }) : super(key: key);

  @override
  State<CustomImageSlider> createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends State<CustomImageSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (widget.autoPlay) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(widget.autoPlayDuration, (timer) {
      if (_currentPage < widget.imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: widget.animationDuration,
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          // Image Slideshow
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          // Indicator
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  widget.imageUrls.length,
                  (index) => GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: widget.animationDuration,
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: _currentPage == index
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LaporAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onSubmit; // Tambahkan parameter onSubmit

  const LaporAppBar(
      {super.key, required this.title, this.onSubmit // Tambahkan ke konstruktor
      });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 70.0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: SvgPicture.asset(
          'assets/cancel.svg',
          width: 17.0,
        ),
      ),
      title: TextBold(
        text: title,
        color: AppColors.darkest,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: ElevatedButton(
            onPressed: onSubmit, // Gunakan onSubmit yang diterima
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors
                  .blue, // Bisa diganti dengan AppColors.green sesuai keinginan
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(64.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            ),
            child: TextSmallMedium(
              text: 'Kirim',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class InputForm extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const InputForm({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextSmallMedium(text: label),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.darkGrey,
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.green),
            ),
          ),
        ),
      ],
    );
  }
}

class TextAreaForm extends StatefulWidget {
  final String label;
  final String hintText;
  final int maxLength;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const TextAreaForm({
    super.key,
    required this.label,
    required this.hintText,
    this.maxLength = 100,
    required this.controller,
    this.onChanged,
  });

  @override
  State<TextAreaForm> createState() => _TextAreaFormState();
}

class _TextAreaFormState extends State<TextAreaForm> {
  int _textLength = 0;

  @override
  void initState() {
    super.initState();
    _textLength = widget.controller.text.length;
    widget.controller.addListener(_updateTextLength);
  }

  void _updateTextLength() {
    setState(() {
      _textLength = widget.controller.text.length;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateTextLength);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextSmallMedium(text: widget.label),
        Stack(
          children: [
            TextFormField(
              controller: widget.controller,
              maxLength: widget.maxLength,
              maxLines: 3,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 16.0,
                ),
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.green),
                ),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: Text(
                '$_textLength/${widget.maxLength}',
                style: const TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SelectForm extends StatelessWidget {
  final String label;
  final String hintText;
  final List<String> items;
  final void Function(String?) onChanged;
  final String? value;

  const SelectForm({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextSmallMedium(text: label),
        ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField<String>(
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down),
            hint: Text(
              hintText,
              style: const TextStyle(
                color: AppColors.darkGrey,
                fontSize: 16.0,
              ),
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.green),
              ),
            ),
            items: items
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: AppColors.darkest,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class DatePickerForm extends StatelessWidget {
  final String label;
  final String hintText;
  final DateTime? selectedDate;
  final void Function(DateTime?)? onChanged;

  const DatePickerForm({
    super.key,
    required this.label,
    required this.hintText,
    this.selectedDate,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextSmallMedium(text: label),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (picked != null && onChanged != null) {
              onChanged!(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                      : hintText,
                  style: TextStyle(
                    color: selectedDate != null
                        ? AppColors.darkest
                        : AppColors.darkGrey,
                    fontSize: 16.0,
                  ),
                ),
                const Icon(Icons.calendar_today, color: AppColors.darkGrey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimePickerForm extends StatelessWidget {
  final String label;
  final String hintText;
  final TimeOfDay? selectedTime;
  final void Function(TimeOfDay?)? onChanged;

  const TimePickerForm({
    super.key,
    required this.label,
    required this.hintText,
    this.selectedTime,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextSmallMedium(text: label),
        InkWell(
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: selectedTime ?? TimeOfDay.now(),
            );
            if (picked != null && onChanged != null) {
              onChanged!(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedTime != null
                      ? selectedTime!.format(context)
                      : hintText,
                  style: TextStyle(
                    color: selectedTime != null
                        ? AppColors.darkest
                        : AppColors.darkGrey,
                    fontSize: 16.0,
                  ),
                ),
                const Icon(Icons.access_time, color: AppColors.darkGrey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ImagePickerForm extends StatefulWidget {
  final String label;
  final String hintText;
  final List<String> imagePaths; // Ubah menjadi List untuk multiple images
  final Function(List<String>)
      onImagesSelected; // Callback untuk multiple images
  final VoidCallback? onTap;

  const ImagePickerForm({
    super.key,
    required this.label,
    required this.hintText,
    required this.imagePaths,
    required this.onImagesSelected,
    this.onTap,
  });

  @override
  State<ImagePickerForm> createState() => _ImagePickerFormState();
}

class _ImagePickerFormState extends State<ImagePickerForm> {
  Future<void> _pickImage(BuildContext context) async {
    if (widget.imagePaths.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maksimal 5 gambar yang dapat dipilih')),
      );
      return;
    }

    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await showDialog<XFile?>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pilih Sumber Gambar'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Dari Galeri'),
                  onTap: () async {
                    Navigator.pop(
                      context,
                      await picker.pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 800,
                        maxHeight: 800,
                        imageQuality: 70,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Dari Kamera'),
                  onTap: () async {
                    Navigator.pop(
                      context,
                      await picker.pickImage(
                        source: ImageSource.camera,
                        maxWidth: 800,
                        maxHeight: 800,
                        imageQuality: 70,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      );

      if (pickedFile != null) {
        final List<String> updatedPaths = List.from(widget.imagePaths)
          ..add(pickedFile.path);
        widget.onImagesSelected(updatedPaths);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _removeImage(int index) {
    final List<String> updatedPaths = List.from(widget.imagePaths)
      ..removeAt(index);
    widget.onImagesSelected(updatedPaths);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextSmallMedium(text: widget.label),
        const SizedBox(height: 8.0),
        if (widget.imagePaths.isEmpty)
          InkWell(
            onTap: () => _pickImage(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.hintText,
                      style: const TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 16.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.add_photo_alternate,
                      color: AppColors.darkGrey),
                ],
              ),
            ),
          ),
        if (widget.imagePaths.isNotEmpty) ...[
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imagePaths.length +
                  (widget.imagePaths.length < 5 ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == widget.imagePaths.length) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: InkWell(
                      onTap: () => _pickImage(context),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add_photo_alternate,
                          color: AppColors.darkGrey,
                          size: 32,
                        ),
                      ),
                    ),
                  );
                }

                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(widget.imagePaths[index]),
                          width: 100,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 12,
                      child: GestureDetector(
                        onTap: () => _removeImage(index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.imagePaths.length}/5 gambar',
            style: const TextStyle(
              color: AppColors.darkGrey,
              fontSize: 12.0,
            ),
          ),
        ],
      ],
    );
  }
}

class PinPointInput extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? initialFaculty;

  const PinPointInput({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.initialFaculty,
  });

  @override
  State<PinPointInput> createState() => _PinPointInputState();
}

class _PinPointInputState extends State<PinPointInput> {
  LatLng? _selectedLocation;
  String? _selectedFaculty;

  void _pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PinMapPage(
          initialLocation: _selectedLocation,
          selectedFaculty: widget.initialFaculty,
        ),
      ),
    );

    if (result != null && result is Map) {
      final LatLng location = result['location'];
      final String? faculty = result['faculty'];

      setState(() {
        _selectedLocation = location;
        _selectedFaculty = faculty;
        widget.controller.text =
            '${location.latitude.toStringAsFixed(6)}, ${location.longitude.toStringAsFixed(6)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextSmallMedium(text: widget.label),
        ElevatedButton(
          onPressed: _pickLocation,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            _selectedLocation == null ? widget.hintText : 'Lokasi Dipilih',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        if (_selectedLocation != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${_selectedLocation!.latitude.toStringAsFixed(6)}, ${_selectedLocation!.longitude.toStringAsFixed(6)}',
                  style: const TextStyle(
                    color: Color(0xFF7C7C7C),
                    fontSize: 12.0,
                  ),
                ),
              ),
              if (_selectedFaculty != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    'Fakultas: $_selectedFaculty',
                    style: const TextStyle(
                      color: Color(0xFF7C7C7C),
                      fontSize: 12.0,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
