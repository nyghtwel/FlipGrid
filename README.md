#  Flipgrid Interview 

## Info
- Xcode 13.2.1
- iOS 15.2

## Description
I used a MVVM architecture approach and in SwiftUI and Combine. The two main views are the `ProfileCreationView` 
and `ConfirmationView`. As requested email and password are the only two field required to submit the form. If an 
incorrect email or password is used I added some error UI to help improve the UX experience. Right now for the email I 
only check if it isn't empty or if it satisfies a simple regex condition of 
"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" that I got online. For password I just checked if the password 
isn't empty. 

Once a user is submitted it navigates to the ConfirmationView where it'll show the fields the user submitted. If a 
user submitted a website url I also added a link to the page to also access the url in safari. If the sign in button is 
pressed then the view pops backs to the `ProfileCreationView` 

I decided on the MVVVM approach because it helps simplies the testing of UX logic and the user logic. Where I only needed
to test the `User` model and the view models. 
  
## Future Improvements 

- Add a more robust email checker and password strength checker. This would be some kind of service or more custom regex
 that checks if the email is valid or if the password is safe enough. 
 
