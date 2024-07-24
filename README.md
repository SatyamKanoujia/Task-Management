<p align="center">
 <img src="https://github.com/user-attachments/assets/e1f6df9a-8e37-4609-8420-eb79c2cb5f43" width="450" height="250">
</p>

# Task Management App


Task Management along with Role-based access control (RBAC)

## Features
- Email & Password Authentication
- Persisting Auth State
- Searching Products
- Filtering Products (Based on Category)
- Product Details
- Rating
- Getting Deal of the Day
- Cart
- Checking out with Google/Apple Pay
- Viewing My Orders
- Viewing Order Details & Status
- Sign Out
- Admin Panel
    - Viewing All Products
    - Adding Products
    - Deleting Products
    - Viewing Orders
    - Changing Order Status
 
## Screenshots
 - User Side
<div style="display: flex; flex-direction: row;">
<img src = "https://github.com/SatyamKanoujia/amazone_clone/assets/126379275/b2f15271-671f-4619-a9e4-d95097184669.jpg" width="250" height="600">
&nbsp;&nbsp;&nbsp;
<img src = "https://github.com/SatyamKanoujia/amazone_clone/assets/126379275/667e2030-1b52-4cd6-9362-dee6633024c5.jpg" width="250" height="600">
&nbsp;&nbsp;&nbsp;
<img src = "https://github.com/SatyamKanoujia/amazone_clone/assets/126379275/32b81130-d7cd-40ff-a45a-ed00c03bff6a.jpg" width="250" height="600">
&nbsp;&nbsp;&nbsp;
</div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div style="display: flex; flex-direction: row;">
<img src = "https://github.com/SatyamKanoujia/amazone_clone/assets/126379275/cffcdef7-d3e8-4d35-914b-b8ffa7da883c.jpg" width="250" height="600">
&nbsp;&nbsp;&nbsp;
<img src = "https://github.com/SatyamKanoujia/amazone_clone/assets/126379275/d467aa91-a9b5-446b-b701-1a5911bcfadc.jpg" width="250" height="600">
&nbsp;&nbsp;&nbsp;
<img src = "https://github.com/SatyamKanoujia/amazone_clone/assets/126379275/f63a7dbd-db87-421e-b2f4-e46e46b4fa5a.jpg" width="250" height="600">
&nbsp;&nbsp;&nbsp;
</div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div style="display: flex; flex-direction: row;">
<img src = "https://github.com/SatyamKanoujia/amazone_clone/assets/126379275/bb98fbe0-0822-456e-9925-81bfe7953698.jpg" width="250" height="600">
&nbsp;&nbsp;&nbsp;
<img src = "https://github.com/SatyamKanoujia/amazone_clone/assets/126379275/53112f71-73da-4359-bc15-bf995d1cc724.jpg" width="250" height="600">
&nbsp;&nbsp;&nbsp;
<img src = "https://github.com/SatyamKanoujia/amazone_clone/assets/126379275/0c029f4f-16ed-4ce1-88c4-3a6960fe3c61.jpg" width="250" height="600">
&nbsp;&nbsp;&nbsp;

- Admin Side
<div style="display: flex; flex-direction: row;">
<img src = "https://github.com/SatyamKanoujia/amazone_clone/assets/126379275/114f3635-a716-4447-98fc-7e2c5abbbb23.jpg" width="250" height="600">
&nbsp;&nbsp;&nbsp;
<img src = "https://github.com/SatyamKanoujia/amazone_clone/assets/126379275/beca789e-b83a-4eff-ba56-8351caf30bd6.jpg" width="250" height="600">
&nbsp;&nbsp;&nbsp;
<img src = "https://github.com/SatyamKanoujia/amazone_clone/assets/126379275/f2f2d4c5-4f90-44b6-8f75-6df570af062a.jpg" width="250" height="600">
&nbsp;&nbsp;&nbsp;
</div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

## Running Locally
After cloning this repository, migrate to ```amazone_clone``` folder. Then, follow the following steps:
- Create MongoDB Project & Cluster
- Click on Connect, follow the process where you will get the uri.- Replace the MongoDB uri with yours in ```server/index.js```.
- Head to ```lib/constant/global_variable.dart``` file, replace <yourip> with your IP Address. 
- Create Cloudinary Project, enable unsigned operation in settings.
- Head to ```lib/features/admin/services/admin_services.dart```, replace ```dhch0lsvt``` and ```nxv7mlgl``` with your Cloud Name and Upload Preset respectively.

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
**Server**: Node.js, Express, Mongoose, MongoDB, Cloudinary

**Client**: Flutter, Provider
    
## Feedback

If you have any feedback, please reach out to me at skanoujia9@gmail.com
