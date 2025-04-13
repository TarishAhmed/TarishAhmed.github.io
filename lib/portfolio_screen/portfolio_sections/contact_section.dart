// Contact section for portfolio webapp
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../assets.dart';
import '../../common/shader_effect.dart';
import '../../common/ticking_builder.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({
    Key? key,
    required this.email,
    required this.phone,
    required this.linkedIn,
    required this.github,
  }) : super(key: key);

  final String email;
  final String phone;
  final String linkedIn;
  final String github;

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;
  bool _showThanks = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _showThanks = true;
      });

      // Reset form after a delay
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        setState(() {
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
          _showThanks = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildSectionHeader('CONTACT ME'),

            const Gap(30),

            // Contact layout (form and info)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contact form
                // Expanded(flex: 3, child: _buildContactForm()),

                // const Gap(40),

                // Contact info
                Expanded(flex: 2, child: _buildContactInfo()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(width: 4, height: 24, color: Colors.red),
        const Gap(10),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Exo',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 0.5.seconds).slide(begin: const Offset(-0.2, 0));
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.red.withOpacity(0.3), width: 2),
        boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.1), blurRadius: 20, spreadRadius: 5)],
      ),
      child:
          _showThanks
              ? _buildThankYouMessage()
              : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's Work Together",
                      style: TextStyle(
                        fontFamily: 'Exo',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade200,
                      ),
                    ),

                    const Gap(20),

                    // Name field
                    _buildTextField(
                      controller: _nameController,
                      label: 'Your Name',
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),

                    const Gap(20),

                    // Email field
                    _buildTextField(
                      controller: _emailController,
                      label: 'Your Email',
                      icon: Icons.email_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const Gap(20),

                    // Message field
                    _buildTextField(
                      controller: _messageController,
                      label: 'Your Message',
                      icon: Icons.message_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a message';
                        }
                        if (value.length < 10) {
                          return 'Message is too short';
                        }
                        return null;
                      },
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                    ),

                    const Gap(30),

                    // Submit button
                    Consumer<FragmentPrograms?>(
                      builder: (context, fragmentPrograms, _) {
                        Widget submitBtn = SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: Colors.red.withOpacity(0.3),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 5,
                              shadowColor: Colors.red.withOpacity(0.5),
                            ),
                            child:
                                _isLoading
                                    ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                    )
                                    : const Text(
                                      'SEND MESSAGE',
                                      style: TextStyle(
                                        fontFamily: 'Exo',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    ),
                          ),
                        );

                        if (fragmentPrograms == null) return submitBtn;

                        return TickingBuilder(
                          builder: (context, time) {
                            return AnimatedSampler((image, size, canvas) {
                              const double overdrawPx = 10;
                              final shader = fragmentPrograms.ui.fragmentShader();
                              shader
                                ..setFloat(0, size.width)
                                ..setFloat(1, size.height)
                                ..setFloat(2, time)
                                ..setImageSampler(0, image);
                              Rect rect = Rect.fromLTWH(
                                -overdrawPx,
                                -overdrawPx,
                                size.width + overdrawPx,
                                size.height + overdrawPx,
                              );
                              canvas.drawRect(rect, Paint()..shader = shader);
                            }, child: submitBtn);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
    ).animate().fadeIn(duration: 0.8.seconds, delay: 0.3.seconds).slide(begin: const Offset(-0.2, 0));
  }

  Widget _buildThankYouMessage() {
    return SizedBox(
      height: 320,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, size: 80, color: Colors.red.shade300),
            const Gap(20),
            Text(
              'Thank you for your message!',
              style: TextStyle(
                fontFamily: 'Exo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade200,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            const Text(
              'I will get back to you as soon as possible.',
              style: TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ).animate().scale();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      textCapitalization: textCapitalization,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        filled: true,
        fillColor: Colors.black26,
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.red.withOpacity(0.3), width: 2),
        boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.1), blurRadius: 20, spreadRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "I'm Available For Freelance Work",
            style: const TextStyle(fontFamily: 'Exo', fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),

          const Gap(10),

          Text(
            "Feel free to get in touch with me. I am always open to discussing new projects, creative ideas or opportunities to be part of your vision.",
            style: const TextStyle(fontSize: 16, color: Colors.white70, height: 1.6),
          ),

          const Gap(40),

          // Contact info items
          _buildContactInfoItem(
            icon: Icons.email,
            title: 'Email',
            value: widget.email,
            onTap: () {
              // Add email launch functionality
              launchUrlString(
                'mailto:${widget.email}?subject=Contact from Portfolio&body=Hello Tarish,',
                mode: LaunchMode.externalApplication,
              );
            },
          ),

          _buildContactInfoItem(
            icon: Icons.phone,
            title: 'Phone',
            value: widget.phone,
            onTap: () {
              // Add phone call functionality
              launchUrlString('tel:${widget.phone}', mode: LaunchMode.externalApplication);
            },
          ),

          _buildContactInfoItem(
            icon: Icons.link,
            title: 'LinkedIn',
            value: widget.linkedIn,
            onTap: () {
              // Add LinkedIn URL launcher
              launchUrlString(widget.linkedIn, mode: LaunchMode.externalApplication);
            },
          ),

          _buildContactInfoItem(
            icon: Icons.code,
            title: 'GitHub',
            value: widget.github,
            onTap: () {
              // Add GitHub URL launcher
              launchUrlString(widget.github, mode: LaunchMode.externalApplication);
            },
          ),

          // const Gap(40),

          // // Social media icons
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     _buildSocialIcon(Icons.south_america_outlined, Colors.blue, () {
          //       // X.com action
          //       launchUrlString('https://x.com/yourhandle', mode: LaunchMode.externalApplication);
          //     }),
          //     _buildSocialIcon(Icons.g_mobiledata, Colors.red, () {}),
          //     _buildSocialIcon(Icons.telegram, Colors.blue.shade400, () {}),
          //     _buildSocialIcon(Icons.link, Colors.teal, () {}),
          //   ],
          // ),
        ],
      ).animate().fadeIn(duration: 0.8.seconds, delay: 0.5.seconds).slide(begin: const Offset(0.2, 0)),
    );
  }

  Widget _buildContactInfoItem({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: Colors.red.shade300),
            ),
            const Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  const Gap(5),
                  Text(value, style: const TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(23),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(icon, color: color, size: 26),
        ),
      ),
    );
  }
}
