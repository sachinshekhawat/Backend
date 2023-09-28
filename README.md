 
                        
                                                  ChatBeyondYou(CBY)

                        1. Authentication part uses MongoDb and RestApi as Backend using NodeJs.
                        2. Flutter application as Frontend very much related to React and For chatting part using Firebase Realtime Database.

(I) System Design Explaination : 

1. **User Interface** : The frontend user interface allows users to interact with the system and sends HTTP requests for various actions, including authentication and chat messages.

2. **LoadBalancer** : The load balancer distributes incoming HTTP requests to multiple instances of the Authentication API Service for load distribution and redundancy.(yet Not able to implement but can be Implemented)

3. **Authentication (MongoDB)** : The Authentication component uses MongoDB as the backend database for user authentication. It receives API requests from the User Interface and responds with authentication tokens.

4. **Authentication API Service**: This service handles authentication requests from the User Interface. It communicates with the Authentication (MongoDB) component to validate user credentials and generate authentication tokens. It responds to HTTP requests with tokens.

5. **Redis Cache**: The Redis Cache serves as a caching layer to store frequently accessed data, reducing database load. It receives cache requests from various components, such as requests for user profiles and frequently used chat messages.(Used in Big Markets)

6. **Chat Application (Firebase Realtime Database)**: The Chat Application component uses Firebase Realtime Database to store and retrieve chat messages, user profiles, and chat room data. It receives and responds to HTTP requests from the User Interface for chat-related actions.

Also Consist of AI ChatBot Where user can chat in their terms and Conditions that is done through an free rapid Api. 


(II) Api Deployment : 

               1. Api Deployed on Render.com 
               2. Api hosted is : https://iby-backend.onrender.com/api/auth/end , 
                  endpoint is defined by word --> end .
               3. end can be of any three end points (i) getusers - > to get all users which are in community  (ii)login for authentication   (iii)updatePic to update the profile pic 
              

(III) DeployMent : 

   APK  link --> 
   
             https://drive.google.com/drive/folders/1IfU_06KbLWTttKnnWhxRZBXoL7GN6YsI?usp=sharing

   OR Second Way

             1. Download Android Studio 
             2. Through Version control paste the link and wait while load 
             3. Necessary - flutter pre installation is mandatory
             4. Then run the application through Enulator Device inside the Android Studio


(IV) MyDetails :  

                         Name - Sachin Shekhawat
                         Adm No - 21JE0796
                         Branch - Computer Science and Engineering
                         Institute - Indian Institute of Technology(Indian School of Mines) Dhanbad
