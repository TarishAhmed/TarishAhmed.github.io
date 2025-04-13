// Resume data model to store professional information
class ResumeData {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String linkedIn;
  final String github;
  final String tagline;
  final String summary;
  final List<Experience> experiences;
  final List<Education> education;
  final List<Skill> skills;
  final List<Project> projects;

  ResumeData({
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.linkedIn,
    required this.github,
    required this.tagline,
    required this.summary,
    required this.experiences,
    required this.education,
    required this.skills,
    required this.projects,
  });

  // Sample data based on your resume
  factory ResumeData.sampleData() {
    return ResumeData(
      name: "Tarish Ahmed",
      title: "Software Developer",
      email: "tarishahmed40@gmail.com",
      phone: "+918138001002",
      linkedIn: "https://www.linkedin.com/in/tarishahmed/",
      github: "https://github.com/TarishAhmed",
      tagline: "Building beautiful cross-platform experiences",
      summary:
          "Experienced mobile application developer with expertise in Flutter and Dart. "
          "Passionate about creating intuitive, responsive interfaces and implementing "
          "innovative solutions that enhance user experience.",
      experiences: [
        Experience(
          company: "Tijoree Money",
          role: "Software Developer II",
          duration: "2023 - Present",
          description: [
            "Led frontend development for a unified product solution, reducing costs by 25% through the seamless integration of two distinct products.",
            "Developed and optimized UI for VISA (VPA Solutions) and Mastercard ICCP virtual card creation, building CMS and also implementing features like scheduled card creation, bulk issuance, and automated payments—contributing to ₹200 CR in average monthly transactions.",
            "Designed and built the user interface for Tijoree Pay, integrating Yes Bank and Unity Bank, enhancing user experience, and increasing retention by 20%.",
            "Implemented a secure authentication flow with OTP splitting, improving security for GST and utility payments, resulting in ₹1500 CR annual transactions.",
            "Developed frontend solutions for B2B utility payments, integrating BBPS APIs, Maker-Checker workflows, auto-bill payment scheduling, and invoice-linking using OCR and email scraping.",
            "Provided guidance on UX best practices, assisting UI/UX teams with support for design library creation and adhering strictly to them.",
            "Collaborated with stakeholders, designers, and backend developers to ensure seamless user experiences and business alignment.",
            "Worked closely with QA teams to ensure bug-free releases across 50+ modules and 4 products.",
            "Contributed to feature adoption and revenue growth, driving a 33% increase through UI enhancements and improved accessibility.",
          ],
          technologies: ["Flutter", "Dart", "Firebase", "RESTful APIs"],
          apps: [
            AppShowcase(title: "Corporate Cards Tijoree", url: "https://cards.tijoree.money"),
            AppShowcase(title: "Tijoree Money Homepage", url: "https://tijoree.money"),
            AppShowcase(title: "Current Account Tijoree", url: "https://app.tijoree.money"),
          ],
        ),
        Experience(
          company: "uFaber",
          role: "Software Developer",
          duration: "2022 - 2023",
          description: [
            "Launched and maintained three educational technology applications—FluentLife, UPSC Pathshala, and IELTS Ninja—collectively achieving over 100,000 downloads and more than 5,000 daily active users.",
            "FluentLife: Developed an English communication enhancement app featuring interactive AI chatbots, grammar quizzes, vocabulary building, pronunciation guides, and live masterclasses, including debates, reading clubs, live speaking practice with other users and group chats with several activities like question answer sessions and polls.",
            "UPSC Pathshala: maintained a comprehensive UPSC exam preparation platform offering high-quality video lectures, personalized mentoring, and extensive study materials covering subjects like Polity, History, and Geography, along with daily current affairs content and quizzes.",
            "IELTS Ninja: Built an application providing personalized courses for IELTS and PTE exam preparation, catering to the needs of over 500,000 test-takers annually, with a variety of trainer-led courses at different price points.",
            "Implemented advanced features such as cloud calling and group chat activities to enhance user engagement and communication within the apps.",
            "Utilized Firebase and Google Cloud Platform (GCP) tools to enhance functionality and performance:",
            "Cloud Functions: Implemented serverless backend code execution in response to events and HTTPS requests, enabling seamless scalability. Group chat and Speaking partner was completely serverless. It was run using Cloud Functions. Moreover, the pronunciation helper also relied on Cloud Functions to analyze and generate reports.",
            "Cloud Tasks: Managed the execution of time-consuming tasks asynchronously, ensuring efficient handling of operations like creating backups of large datasets while respecting external API rate limits. Cloud tasks were basically the cron job equivalent of the serverless model that we followed.",
            "Cloud Logging: Monitored and debugged applications by writing and viewing logs, providing valuable insights into performance and facilitating prompt issue resolution.",
            "BigQuery: Analyzed large datasets to enable data-driven decision-making, improving app features and user engagement.",
            "Ensured applications are robust, scalable, and capable of providing a seamless user experience to a growing user base through the integration of advanced tools and technologies.",
          ],
          technologies: ["Flutter", "Dart", "State Management", "API Integration"],
          apps: [
            AppShowcase(
              title: 'Fluent English Speaking App',
              url: "https://play.google.com/store/apps/details?id=com.ufaber.fluentlife&hl=en&gl=US",
            ),
            AppShowcase(
              title: 'UPSC Pathshala',
              url: "https://play.google.com/store/apps/details?id=com.ufaber.upscguru&hl=en&gl=US",
            ),
            AppShowcase(
              title: 'IELTS Ninja',
              url: "https://play.google.com/store/apps/details?id=com.ufaber.ieltsninja&hl=en&gl=US",
            ),
          ],
        ),
        Experience(
          company: "Corbel Business Applications Pvt. Ltd.",
          role: "Software Developer",
          duration: "2021 - 2022",
          description: [
            "Launched two full-fledged products (Along with designing the Api used) [Abemart, Progresser], ERP and E-commerce app, launched multiple websites including but not limited to, traceagtech.com, corbelbiz.com",
          ],
          technologies: ["Flutter", "Dart", "State Management", "API Integration"],
          apps: [
            AppShowcase(title: 'Traceag Homepage', url: "https://traceagtech.com/"),
            AppShowcase(title: 'Abemart', url: "https://abemart.in/"),
            AppShowcase(
              title: 'Trace Agtech',
              url: "https://play.google.com/store/apps/details?id=com.traceipm.agtech&hl=en&gl=US",
            ),
            AppShowcase(title: 'Corbel Homepage', url: "https://corbelbiz.com/"),
          ],
        ),
        Experience(
          company: "Ingerem",
          role: "Systems Engineer",
          duration: "2020 - 2021",
          description: [
            "Promoted to a four-member research and development team to build interactive operating manuals and training products.",
            "In charge of the entire cloud architecture of the company, taking care of document management tasks.",
          ],
          technologies: ["Flutter", "Dart", "State Management", "API Integration"],
          apps: [],
        ),
      ],
      education: [
        Education(
          institution: "Amrita School Of Arts And Sciences, Kochi",
          degree: "Master of Computer Applications (MCA)",
          duration: "2015 - 2020",
          description:
              "Hosted multiple CSI fests and participated and won in multiple competitions including extempore, quizzes. Participated in inter-college level competitions for athletics.",
        ),
      ],
      skills: [
        Skill(name: "Flutter", level: 0.9, category: "Mobile Development"),
        Skill(name: "Dart", level: 0.9, category: "Programming Languages"),
        Skill(name: "Android Native", level: 0.7, category: "Mobile Development"),
        Skill(name: "Firebase", level: 0.8, category: "Backend"),
        Skill(name: "RESTful APIs", level: 0.8, category: "Backend"),
        Skill(name: "UI/UX Design", level: 0.7, category: "Design"),
        Skill(name: "Git", level: 0.8, category: "Tools"),
        Skill(name: "JavaScript", level: 0.7, category: ["Programming Languages", "Web Development"]),
        Skill(name: "HTML/CSS", level: 0.7, category: "Web Development"),
      ],
      projects: [
        Project(
          title: "Portfolio Webapp",
          description:
              "Interactive portfolio website built with Flutter showcasing advanced shader effects and animations.",
          technologies: ["Flutter", "Dart", "Shader Programming", "Animation"],
          imageUrl: "assets/images/portfolio.png",
          url: "#",
        ),
      ],
    );
  }
}

class Experience {
  final String role;
  final String company;
  final String duration;
  final List<String> description; // Changed from String to List<String>
  final List<String> technologies;
  final List<AppShowcase> apps;

  Experience({
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
    required this.technologies,
    this.apps = const [],
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      role: json['role'],
      company: json['company'],
      duration: json['duration'],
      description: List<String>.from(json['description']), // Convert from JSON to List<String>
      technologies: List<String>.from(json['technologies']),
      apps: json['url'],
    );
  }
}

class AppShowcase {
  final String title;
  final String? description;
  final String? imageUrl;
  final String url;

  AppShowcase({required this.title, this.description, this.imageUrl, required this.url});
}

class Education {
  final String institution;
  final String degree;
  final String duration;
  final String description;

  Education({required this.institution, required this.degree, required this.duration, required this.description});
}

class Skill {
  final String name;
  final double level; // 0.0 to 1.0
  final dynamic category; // Can be String or List<String>

  List<String> get categories {
    if (category is String) {
      return [category];
    } else if (category is List) {
      return List<String>.from(category);
    }
    return [];
  }

  Skill({required this.name, required this.level, this.category});
}

class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String imageUrl;
  final String url;

  Project({
    required this.title,
    required this.description,
    required this.technologies,
    required this.imageUrl,
    required this.url,
  });
}
