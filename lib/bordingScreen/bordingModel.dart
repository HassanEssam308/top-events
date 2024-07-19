class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Login Screen',
      image: 'image/login.jpg',
      discription: "The login screen features user authentication via email and password,"
          " with a clean, intuitive interface and secure Firebase integration. "

  ),
  UnbordingContent(
      title: 'Add Your Event',
      image: 'image/Screenshot 2024-07-19 102830.png',
      discription: " allows users to create and manage events effortlessly, featuring input fields for event details, date, time"
          ", and location, all within a user-friendly interface."
  ),
  UnbordingContent(
      title: 'Market to event',
      image: 'image/Screenshot (3).png',
      discription: "you to promote your event, reach a larger audience, and drive ticket sales with ease."
          " Use various marketing tools and strategies to maximize your event's visibility and engagement. "
  ),
];