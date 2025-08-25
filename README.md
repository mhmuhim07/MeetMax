# meetmax

A social media app UI built with Flutter. This project covers a complete user authentication flow and an interactive feed, all running on a mock API for demonstration.

# Screenshots
![auth-screen](https://github.com/mhmuhim07/MeetMax/blob/2cb73a0165a2f1d2d193abe207e2d941885e28b1/auth.png)
![feed-screen](https://github.com/mhmuhim07/MeetMax/blob/2cb73a0165a2f1d2d193abe207e2d941885e28b1/feed.png)

# ✨ Features
<ul>
  <li>Pixel-perfect UI from Figma design</li>
  <li>Auth Flow (Sign Up / Sign In)</li>
  <li>Secure Password Hashing (bcrypt) with a migration path for existing users</li>
  <li>Interactive Feed with Posts & Stories</li>
  <li>Like & Comment on posts</li>
  <li>State Management via Provider</li>
  <li>Form Validation with a custom date picker</li>
</ul>

# 🛠️ Tech Stack
<ul>
  <li>Framework: Flutter</li>
  <li>State Management: provider</li>
  <li>Icons: font_awesome_flutter</li>
  <li>Images: cached_network_image</li>
  <li>Date Formatting: intl</li>
  <li>Security: bcrypt</li>
</ul>

## Getting Started
Prerequisites
<ul>
  <li>Flutter SDK</li>
</ul>

Steps
<ol>
  <li>
    Clone the repository <br>
    
    git clone https://github.com/mhmuhim07/MeetMax
  </li>
  <li>
    Navigate to the project directory <br>
    
    cd meetmax
  </li>
  <li>
    Install dependencies <br>
    
    flutter pub get
  </li>
  <li>
    Run the app <br>
    
    flutter run
  </li>
</ol>



## 📝 Mock API & Login
This project uses a mock API, so no backend is needed. You can log in with a pre-defined user to test the feed.
<ul>
  <li>
    Email
    
    test@gmail.com
  </li>
  <li>
    Password
    
    123456
  </li>
</ul>
You can also register new users; their credentials will be securely hashed and stored for the current app session.
