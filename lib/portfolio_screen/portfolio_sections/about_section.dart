// About section for portfolio webapp
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../assets.dart';
import '../../common/shader_effect.dart';
import '../../common/ticking_builder.dart';
import '../../models/resume_data.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key, required this.resumeData}) : super(key: key);

  final ResumeData resumeData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Header
            _buildSectionHeader('ABOUT ME'),

            const Gap(20),

            // Summary with shader effect
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white24, width: 1),
              ),
              child: Text(resumeData.summary, style: const TextStyle(fontSize: 18, height: 1.6, color: Colors.white)),
            ).animate().fadeIn(duration: 0.8.seconds, delay: 0.3.seconds),

            const Gap(40),

            // Experience Header
            _buildSectionHeader('EXPERIENCE'),

            const Gap(20),

            // Experience Cards
            ...List.generate(
              resumeData.experiences.length,
              (index) => _ExperienceCard(experience: resumeData.experiences[index], delay: 0.5 + (index * 0.2)),
            ),

            const Gap(40),

            // Education Header
            _buildSectionHeader('EDUCATION'),

            const Gap(20),

            // Education Cards
            ...List.generate(
              resumeData.education.length,
              (index) => _EducationCard(education: resumeData.education[index], delay: 0.5 + (index * 0.2)),
            ),

            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(width: 4, height: 24, color: Colors.purple),
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
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.experience, required this.delay});

  final Experience experience;
  final double delay;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.purple.withOpacity(0.3), width: 2),
        boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.1), blurRadius: 10, spreadRadius: 1)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.role,
                      style: const TextStyle(
                        fontFamily: 'Exo',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      experience.company,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.purple.shade200),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  experience.duration,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
                ),
              ),
            ],
          ),

          // Display description as bullet points from the List<String>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                experience.description
                    .map(
                      (line) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '• ',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70),
                            ),
                            Expanded(
                              child: Text(
                                line.trim(),
                                style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          ),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                experience.technologies.map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.purple.withOpacity(0.3)),
                    ),
                    child: Text(
                      tech,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white70),
                    ),
                  );
                }).toList(),
          ),
          ...experience.apps
              .map(
                (url) => InkWell(
                  onTap: () {
                    // Add URL launcher functionality
                    launchUrlString(url.url, mode: LaunchMode.externalApplication);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.link, size: 16, color: Colors.purple),
                      const Gap(5),
                      Text(
                        url.title,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.purple.shade200),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    ).animate().fadeIn(duration: 0.7.seconds, delay: delay.seconds).slide(begin: const Offset(0, 0.2));
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard({required this.education, required this.delay});

  final Education education;
  final double delay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.purple.withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      education.degree,
                      style: const TextStyle(
                        fontFamily: 'Exo',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(5),
                    Text(education.institution, style: TextStyle(fontSize: 16, color: Colors.purple.shade200)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  education.duration,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
                ),
              ),
            ],
          ),
          const Gap(10),
          Text(education.description, style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.white70)),
        ],
      ),
    ).animate().fadeIn(duration: 0.7.seconds, delay: delay.seconds).slide(begin: const Offset(0, 0.2));
  }
}
