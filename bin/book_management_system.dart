import 'dart:io';

File file = File('./bin/BookFiles/BooksFileRegistration.csv');

void addBook() {
  try {
    stdout.write('Enter Book Name: ');
    String name = stdin.readLineSync()!;

    stdout.write('Enter Author Name: ');
    String author = stdin.readLineSync()!;

    stdout.write('Enter Edition: ');
    int edition = int.parse(stdin.readLineSync()!);

    file.writeAsStringSync('$name,$author,$edition\n', mode: FileMode.append, flush: true);

    print('Registered Successfully\n');
  } catch (e) {
    print('Error: ${e.toString()}');
  }
}

void viewAllBooks() {
  try {
    String allBooks = file.readAsStringSync();
    List<String> mylist = allBooks.split('\n');
   for(var temp in mylist){
     print('\nBook Name: ${temp.split(',')[0]}');
     print('Book Author: ${temp.split(',')[1]}');
     print('Book Edition: ${temp.split(',')[2]}');
     print('\n');
   }
  } catch (e) {
    print('Error reading file: ${e.toString()}');
  }
}

void findBook() {
  try {
    print('Enter Book Name: ');
    String searchInput = stdin.readLineSync()!;
    String searchFile = file.readAsStringSync();

    List<String> lines = searchFile.split('\n');
    bool found = false;

    for (var line in lines) {
      if (line.isNotEmpty && line.startsWith(searchInput + ',')) {
        print('=> Book Details');
        print('   Book Name: ${line.split(',')[0]}');
        print('   Book Author: ${line.split(',')[1]}');
        print('   Book Edition: ${line.split(',')[2]}\n2');
        found = true;
        break;
      }
    }
    if (!found) {
      print('Book not found.');
    }
  } catch (e) {
    print('Error: ${e.toString()}');
  }
}

void removeBook() {
  try {
    print('Enter Book Name to Remove: ');
    String bookNameToRemove = stdin.readLineSync()!;

    // Read the current contents of the file
    List<String> lines = file.readAsLinesSync();

    // Filter out the line that contains the book name to remove
    List<String> updatedLines = lines.where((line) => !line.startsWith(bookNameToRemove + ',')).toList();

    // Write the updated lines back to the file
    file.writeAsStringSync(updatedLines.join('\n') + '\n', flush: true);

    print('Book "$bookNameToRemove" removed successfully.\n');
  } catch (e) {
    print('Error: ${e.toString()}');
  }
}

void main() {
  int? input;
  print('\n============ Welcome To the Book Management System ============\n');

  do {
    print('''
    1: Add new Book
    2: Search Book
    3: Remove Book
    4: View All books
    5: Exit
    ''');

    try {
      stdout.write('Enter Your Choice: ');
      input = int.parse(stdin.readLineSync()!);

      switch (input) {
        case 1:
          addBook();
          break;
        case 2:
          findBook();
          break;
        case 3:
          removeBook();
          break;
        case 4:
          viewAllBooks();
          break;
        case 5:
          print('Exiting');
          break;
        default:
          print('Invalid choice. Please enter a number between 1 and 5.');
      }
    } catch (e) {
      print('Invalid input. Please enter a valid number.');
    }
  } while (input != 5);
}
