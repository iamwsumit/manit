# NIT Bhopal Study Portal

A comprehensive open-source study portal for students of NIT Bhopal, available as a web application and a Flutter-based cross-platform app for Android, Windows, and macOS. The portal provides notes, previous year question papers (PYQs), assignments, and books for different subjects, organized in a structured manner.

## 🚀 Features
- 📂 **Subject-wise categorized resources** (Notes, PYQs, Assignments, Books)
- 🌐 **Web Application** (Hosted on Firebase Hosting)
- 📱 **Flutter App** (Supports Android, Windows, macOS)
- 🆓 **Open-source & community-driven**
- 📢 **Announcements feature for updates**
- 📖 **Easy contribution by adding new subjects and resources**

---

## 🛠 Technologies Used
- **Frontend (Web App):** HTML, CSS, JavaScript
- **Mobile/Desktop App:** Flutter & Dart
- **Backend & Hosting:** Firebase & GitHub
- **Database:** JSON-based storage
- **Version Control:** Git & GitHub

---

## 📁 Project Structure
```
├── content/              # Contains all study materials (PDFs)
│   ├── subject1/
│   │   ├── notes/
│   │   ├── pyq/
│   │   ├── assignments/
│   │   ├── books/
│   ├── subject2/
│   │   ├── ...
│
├── manitfirst/           # Flutter app source code
│
├── web/                  # Web app source code
│
├── announcement.json     # JSON file for notifications/announcements
│
├── data.json             # Main JSON database (metadata for all subjects & resources)
```

## 🛠️ Technical Architecture

The project consists of three main components:

1. **Web Application** (`/web`)
   - Simple static website with HTML, CSS, and JavaScript
   - Hosted on Firebase Hosting (deployment handled by me)

2. **Flutter Application** (`/manitfirst`)
   - Cross-platform application supporting:
     - Android
     - Windows
     - macOS

3. **Content Management** (`/content`)
   - Organized repository of PDF resources
   - Subject-wise categorization

### 📂 Data Structure

The application uses two main JSON files for data management:

1. **data.json**
   ```json
   {
     "subject_code": {
       "name": "Subject Name",
       "data": {
         "notes": [
           {
             "title": "Resource Title",
             "desc": "Resource Description",
             "link": "Raw GitHub URL to PDF"
           }
         ],
         "pyq": [...],
         "assignments": [...],
         "books": [...]
       }
     }
   }
   ```

2. **announcement.json**
   ```json
   {
     "notifications": [
       {
         "author": "Your Name (e.g., 'By Sumit Kumar')",
         "date": "Date (e.g., '10 Feb 2025')",
         "title": "Title of the announcement",
         "desc": "Description about the announcement",
         "link": "Optional URL if you want to redirect user to specific webpage"
       }
     ]
   }
   ```

---

## 💻 Setup & Installation
To contribute or run the project locally, follow these steps:

### 🔹 Requirement
1. For Web Development:
   - Visual Studio Code with "Live Server" extension
   - A modern web browser

2. For Flutter Development:
   - Flutter SDK (Latest stable version)
   - Dart SDK
   - Android Studio (for Android development)
   - Xcode (for macOS development)
   - Visual Studio (for Windows development)
   - VS Code with Flutter and Dart extensions

3. Version Control:
   - Git

### 🔹 Clone the Repository
```sh
git clone https://github.com/iamwsumit/manit.git
cd manit
```

### 🔹 Running the Web App Locally
Since the web app is a static website, you can run it using a **Live Server Extension** in VS Code:
1. Open the `web/` folder in VS Code.
2. Install the **Live Server** extension if not already installed.
3. Right-click `index.html` and select **Open with Live Server**.
4. The site will open in your browser at `http://127.0.0.1:5500/` or a similar address.

### 🔹 Running the Flutter App
```sh
cd manitfirst
flutter pub get  # Fetch dependencies
flutter run      # Run the app (Choose Android/Windows/macOS)
```

---

## 🤝 How to Contribute
We welcome contributions! Follow these steps to add new resources, subjects, or improve the app:

### 1️⃣ Fork the Repository
Click the **Fork** button on GitHub and clone your forked repo locally.

### 2️⃣ Add Resources or Make Changes

- **Adding Study Resources**
  * Add your PDF resources for **notes, PYQs, assignments, or books** to the respective directory under `/content/[subject]/[category]`
  * Update `data.json` with the resource information:<br><br>
  
    ```json
    {
        "subject_id": {
            "name" : "Subject Name",
            "data": {
                "category": [
                    {
                        "title": "Your Resource Title",
                        "desc": "Brief Description",
                        "link": "Raw GitHub URL to your PDF"
                    }
                ]
            }
        }
    }
    ```
- **Modifying Web/Flutter UI:**
  - Make UI/UX changes inside the `web/` or `manitfirst/` directories accordingly.

- **Adding Announcements:**
  - Update `announcement.json` with a new announcement entry.

### 3️⃣ Commit & Push Changes
```sh
git add .
git commit -m "Added new subject/resource/UI improvement"
git push origin your-branch-name
```

### 4️⃣ Create a Pull Request
Go to the GitHub repo and create a **Pull Request** (PR) describing the changes. The project maintainer will review and merge it.

**Pull Request Guidelines**

- Ensure all PDFs are properly formatted and readable
- Test links before submitting
- Follow existing code style and conventions
- Include clear commit messages
- Add documentation for new features

**Technical Notes**

- The platform only supports PDF files currently
- All resource links must be raw GitHub URLs
- The web application is a static website hosted on Firebase (deployment handled by me)
- Flutter app follows material design guidelines
- No backend server required - all data is managed through JSON files

---

## 📢 Community & Support
Have questions or suggestions? Connect with us:
- Open an **issue** on GitHub
- Join discussions in the **GitHub Discussions** section
- Share feedback via PR comments

Or Contact me :

* [LinkedIn](https://linkedin.com/in/iamwsumit)
* [Email](mailto:me@sumitkmr.com)

---

## 📜 License
This project is licensed under the **MIT License** – you're free to use, modify, and distribute it!

---

🎯 *Happy Learning & Contributing!* 🚀

