<p align="center">
 <img src="https://github.com/user-attachments/assets/e1f6df9a-8e37-4609-8420-eb79c2cb5f43" >
</p>

# Task Management App

**Introduction**
   
Welcome to the Task Management System project! This application is designed to streamline managing tasks and monitoring team activities effectively. Built with Flutter for the frontend and Express.js for the backend, this project leverages modern technologies to provide a seamless and efficient task management experience.

## Features
- **User Authentication**: Secure login and registration using JWT (JSON Web Tokens) for authentication.
- **Task Management**: Users can create, update, delete, and view tasks with ease. Tasks can be marked as completed, helping users track progress effectively.
- **Monitoring**: Managers can monitor tasks assigned to their subordinates, providing oversight and facilitating better team management.
- **Profile Management**: Users can update their profile information, ensuring their details are always current.
- **Responsive Design**: A user-friendly interface that adapts to various screen sizes, ensuring accessibility across all devices.
 
## Screenshots
 - User Side

|Splash Screen|Welcome Screen|Sign Up|Sign In|
|--|--|--|--|
|![](https://github.com/user-attachments/assets/44b7cbdb-bfbe-429e-b06d-fc2a63f9a4b6)|![](https://github.com/user-attachments/assets/21dac582-04e8-4580-bf7e-7bfd5fc64fe8)|![](https://github.com/user-attachments/assets/e312b7ad-d261-4c8d-80b6-9f5539d1df6d)|![](https://github.com/user-attachments/assets/e91a1424-96ab-46c5-a970-0f2231ed4c3d)|

|Home Screen|Add Task|Date Picker|Time Picker|
|--|--|--|--|
|![](https://github.com/user-attachments/assets/24051be1-16c8-4ae1-8f80-777ea8177e22)|![](https://github.com/user-attachments/assets/55baa8db-56c7-40ed-83a7-3b4f94d8ba1d)|![](https://github.com/user-attachments/assets/f4b32d66-e44f-4db6-b6ef-a228f5d116f4)|![](https://github.com/user-attachments/assets/c90cecbc-92ed-4f1b-a6c1-defb44296d20)|

|Task Added|Update Task|Completed Task|Side Bar|
|--|--|--|--|
|![](https://github.com/user-attachments/assets/7f693262-895e-4aff-9916-d880b2496b01)|![](https://github.com/user-attachments/assets/219c1024-dae4-44c0-8a20-9592fde00b1e)|![](https://github.com/user-attachments/assets/299bf4af-36b2-457b-8ac8-5e263c7c0dc1)|![](https://github.com/user-attachments/assets/80da5836-8169-4e6b-be24-7490cb22a91e)|

|Profile Section|Monitoring Section|Task Status of Others|Assigning Task|
|--|--|--|--|
|![](https://github.com/user-attachments/assets/5afa0954-bcde-4e5d-b058-d1d8e239507a)|![](https://github.com/user-attachments/assets/b5be969a-782f-4786-ae46-cebf31ddb022)|![](https://github.com/user-attachments/assets/c3dd907c-5560-469b-a951-a7c94ddaf789)|![](https://github.com/user-attachments/assets/4aaaf93d-d6dd-4e74-a26b-4e3a03d3c6ee)|

## Running Locally
After cloning this repository, migrate to ```task_management``` folder. Then, follow the following steps:
- Create MongoDB Project & Cluster
- Click on Connect, follow the process where you will get the uri.- Replace the MongoDB uri with yours in ```server/index.js```.
- Head to ```lib/src/constant/text_string.dart``` file, replace <yourip> with your IP Address. 

Then run the following commands to run your app:

### Server Side
```bash
  cd server
  npm install
  npm run dev (for continuous development)
  OR
  npm start (to run script 1 time)
```

### Client Side
```bash
  flutter pub get
  open -a simulator (to get iOS Simulator)
  flutter run
```

## Tech Used
**Server**: Node.js, Express, Mongoose, MongoDB

**Client**: Flutter, Provider
    
## Feedback

If you have any feedback, please reach out to me at skanoujia9@gmail.com
