# Overview
Library Web Application

# How to Use LibSys:

Preconfiged Admin: email: vramach@ncsu.edu, password: abcd

### Admins
#### Creating a new admin: 
Home Page -> I am an admin -> login as the preconfiged admin -> back (this will goes to the **List Admins** page)

In the **List Admins** page -> New Admin

Note: Email mush be unique and in correct form.

#### Creating a new member:
In the **List Admins** page -> Member List -> New Member

Note: Email mush be unique and in correct form.

#### Adding a book:
In the **List Admins** page -> Book List -> New Book

#### Checking out a book for a member
In the **List Admins** page -> Book List -> Borrow -> Enter member email -> checkout

#### Returning a book for a member
In the **List Admins** page -> Member List -> Show (will also show a book list that the member checked out) -> Return

#### Viewing the checkout history of a book
In the **List Admins** page -> Book List -> Show -> Checkout History

The checkout history is in the following format:

```
| Order  |	Member  |	       Checkout Time        |	       Return Time        |
| ------ | -------- | --------------------------- | ------------------------- |
|  1     |   David  |  2015-09-25 22:42:26 -0400  | 2015-09-25 23:40:00 -0400 |
|  2     |   Lisa   |  2015-09-26 08:23:15 -0400  |             -             |
```

#### Viewing the checkout history of a member
In the **List Admins** page -> Member List -> Show -> Checkout History

#### Deleting an admin
In the **List Admins** page -> Delete

#### Deleting a member
In the **List Admins** page -> Member List -> Delete
When a member is deleted, the checkout history of the books he's checked out shows his emailID as "Anonymous".

#### Deleting a book
In the **List Admins** page -> Book List -> Delete
When a Book is deleted, the checkout history of the members who've checked out the book remains unaffected.

### Members
#### Signup as a member
Home Page -> Sign Up Now

#### Checking out a book
Home Page -> I am an member -> login as a member (This will redirect to the **List Books** page)

In the **List Books** page -> Borrow -> click the ***Checkout*** Button.

#### Returning a book
In the **List Books** page -> View My Profile (will also show a checked out book list) -> Return 

#### Viewing the checkout history
In the **List Books** page -> View My Profile (will also show a checked out book list) -> Checkout History

#### Search for a book
In the **List Books** page -> Enter any information about the book -> Click ***Search***

### Testing
#### Testing admin controller
```
rake test test/controllers/admins_controller_test.rb
```

#### Testing admin model
```
rake test test/models/admin_test.rb
```

# FAQ
#### For special test cases: 
1. Admin cannot delete a member if he/she is still holding a book.
2. Admin cannot delete a book if the book status is checked out.

#### Preadmin's Profile
1. The preadmin's profile cannot be altered. To test admin's editing function, please log in as normal admins. 
