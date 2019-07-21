Use the Ruby on Rails framework.

Your models must:

[x] Include at least one has_many, at least one belongs_to, and at least two has_many :through relationships
    Users have many songs, instruments, and elements. Songs have many instruments through Instruments-songs and Instruments have many songs in the same way. instruments-songs belong to songs and instruments. elements belong to instruments, songs and users. songs have many elements, and instruments have many elements through songs.

[x]Include a many-to-many relationship implemented with has_many :through associations. The join table must include a user-submittable attribute — that is to say, some attribute other than its foreign keys that can be submitted by the app's user
    Elements are connected to instruments through songs, and they have much information that can be submitted by the user

[x] Your models must include reasonable validations for the simple attributes. You don't need to add every possible validation or duplicates, such as presence and a minimum length, but the models should defend against invalid data.
    validations are present for almost all models, checking for presence of the name attribute at least, and uniqueness where it matters. custom validations have been written for file type using active storage

[x] You must include at least one class level ActiveRecord scope method. a. Your scope method must be chainable, meaning that you must use ActiveRecord Query methods within it (such as .where and .order) rather than native ruby methods (such as #find_all or #sort).
    In the application record model there are two of these methods. There were many more, but I abstracted them to be used by all my models

[X] Your application must provide standard user authentication, including signup, login, logout, and passwords.
      I have a before_action require login set in most of my controllers. For my users show page I compare the @user instance variable with the current_user variable. I use has_secure_password with bcrypt. I have login and logout routes with a sessions controller.
[X] Your authentication system must also allow login from some other service. Facebook, Twitter, Foursquare, Github, etc...
      I used google omniauth
[X] You must include and make use of a nested resource with the appropriate RESTful URLs.
    all of my routes are nested within the user resource
[X] You must include a nested new route with form that relates to the parent resource
    I have this for almost all my models (users/id/instruments/new) etc.
[X] You must include a nested index or show route
    I have this for almost all my models (users/id/instruments/id) etc.
[X] Your forms should correctly display validation errors. a. Your fields should be enclosed within a fields_with_errors class b. Error messages describing the validation failures must be present within the view.
    I use this is all forms, as well as flash notices when applicable
[X] Your application must be, within reason, a DRY (Do-Not-Repeat-Yourself) rails app.
    I abstracted my class methods to the application record model, partials are used where it makes sense, and set methods are used when it makes sense
[X] Logic present in your controllers should be encapsulated as methods in your models.
    scopes are used to set instance variables in my index action
[X] Your views should use helper methods and partials when appropriate.
      see above
[X] Follow patterns in the Rails Style Guide and the Ruby Style Guide.
      
[X] Do not use scaffolding to build your project. Your goal here is to learn. Scaffold is a way to get up and running quickly, but learning a lot is not one of the benefits of scaffolding.
    I used rails generate resource
