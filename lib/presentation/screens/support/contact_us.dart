import 'package:dio/dio.dart';
import 'package:real_estate/data/data_provider/remote_url.dart';

import '../../../state_inject_package_names.dart';

class ContactUs extends StatefulWidget {
  final String? propertyId;
  final bool? isSendingEnquiry;

  const ContactUs({super.key, this.propertyId, this.isSendingEnquiry = false});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false; // Track the loading state

  // Function to validate email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  // Function to validate phone number
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Enter a valid 10-digit phone number";
    }
    return null;
  }

  // Function to validate non-empty fields
  String? _validateNonEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  // API call to submit the form data
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isLoading = true; // Show loader
        });
      });

      if (widget.isSendingEnquiry == false) {
        try {
          final response = await Dio().post(
            "${RemoteUrls.baseUrl}send-contact-message",
            data: {
              "name": _nameController.text,
              "email": _emailController.text,
              "subject": _subjectController.text,
              "message": _messageController.text,
              "phone": _phoneController.text,
            },
          );

          if (response.statusCode == 200) {
            debugPrint("Response: ${response.data}");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Message sent successfully!")),
            );
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Failed to send message. Please try again.")),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${e.toString()}")),
          );
        } finally {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _isLoading = false; // Show loader
            });
          });
        }
      } else {
        String? tokens;
        var _mainHeaders;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = await prefs.getString("token");
        _mainHeaders = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token ?? tokens}'
        };
        print("Api main header ================>${_mainHeaders} ");
        try {
          final response = await Dio().post("${RemoteUrls.baseUrl}send-enquiry",
              data: {
                "name": _nameController.text,
                "email": _emailController.text,
                "subject": _subjectController.text,
                "message": _messageController.text,
                "phone": _phoneController.text,
                "property_id": widget.propertyId,
              },
              options: Options(headers: _mainHeaders));

          if (response.statusCode == 200) {
            debugPrint("Response: ${response.data}");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Enquiry Sent successfully!")),
            );
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Failed to send message. Please try again.")),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${e.toString()}")),
          );
        } finally {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _isLoading = false; // Show loader
            });
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(
          360,
          100,
        ),
        child: Container(
          width: 360,
          height: 200,
          decoration: const BoxDecoration(
            color: Color(0xFFE7EBF4),
            boxShadow: [
              BoxShadow(
                color: Color(0x1E000000),
                blurRadius: 8,
                offset: Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35.0, left: 16, right: 16),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/Yash/images/ZingCityLogo.png",
                      width: 50.03,
                      height: 35.01,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios),
                      Text(
                        (widget.isSendingEnquiry == true)
                            ? "Send Enquiry"
                            : "Contact Us",
                        style: const TextStyle(
                          color: Color(0xFF30469A),
                          fontSize: 18,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: _validateNonEmpty,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                      validator: _validateEmail,
                    ),
                    Visibility(
                        visible: widget.isSendingEnquiry == false,
                        child: const SizedBox(height: 16)),
                    Visibility(
                      visible: widget.isSendingEnquiry == false,
                      child: TextFormField(
                        controller: _subjectController,
                        decoration: const InputDecoration(
                          labelText: "Subject",
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateNonEmpty,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: "Message",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      validator: _validateNonEmpty,
                    ),
                    Visibility(
                        visible: widget.isSendingEnquiry == false,
                        child: const SizedBox(height: 16)),
                    Visibility(
                      visible: widget.isSendingEnquiry == false,
                      child: TextFormField(
                        maxLength: 10,
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          counterText: "",
                          labelText: "Phone",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: _validatePhone,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
