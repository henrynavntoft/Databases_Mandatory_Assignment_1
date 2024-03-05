-- #################################
-- Primary table

DROP TABLE IF EXISTS books;

CREATE TABLE books(
    book_pk          TEXT UNIQUE,
    publisher_fk     TEXT,
    book_name        TEXT,
    FOREIGN KEY (publisher_fk) REFERENCES publishers(publisher_pk),
    PRIMARY KEY (book_pk)
) WITHOUT ROWID;

INSERT INTO books VALUES
("1", "1", "The Great Gatsby"),
("2", "2", "To Kill a Mockingbird");

-- #################################
-- Primary table

DROP TABLE IF EXISTS publishers;

CREATE TABLE publishers (
    publisher_pk    TEXT UNIQUE,
    publisher_name  TEXT UNIQUE,
    PRIMARY KEY (publisher_pk)
) WITHOUT ROWID;

INSERT INTO publishers VALUES
("1", "Penguin Classics"),
("2", "HarperCollins");


-- #################################
-- Primary table

DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
    author_pk       TEXT UNIQUE,
    author_name     TEXT,
    PRIMARY KEY (author_pk)
) WITHOUT ROWID;

INSERT INTO authors VALUES
("1", "F. Scott Fitzgerald"),
("2", "Harper Lee");


-- #################################

DROP TABLE IF EXISTS categories;
-- Primary table

CREATE TABLE categories (
    category_pk     TEXT UNIQUE,
    category_name   TEXT UNIQUE,
    PRIMARY KEY (category_pk)
) WITHOUT ROWID;

INSERT INTO categories VALUES
("1", "Classic Literature"),
("2", "Fiction");


-- #################################
-- Lookup table

DROP TABLE IF EXISTS books_format;

CREATE TABLE books_format (
    book_fk         TEXT,
    format_type     TEXT,
    FOREIGN KEY (book_fk) REFERENCES books(book_pk),
    PRIMARY KEY (book_fk, format_type) -- Composite key
) WITHOUT ROWID;

INSERT INTO books_format VALUES
("1", "Hardcover"),
("1", "Paperback"),
("1", "Ebook"),
("2", "Hardcover"),
("2", "Paperback"),
("2", "Ebook");


-- #################################
-- Junction table for books and authors

DROP TABLE IF EXISTS book_authors;

PRAGMA foreign_keys = ON;

CREATE TABLE book_authors (
    book_fk         TEXT,
    author_fk       TEXT,
    FOREIGN KEY (book_fk) REFERENCES books(book_pk),
    FOREIGN KEY (author_fk) REFERENCES authors(author_pk), 
    PRIMARY KEY (book_fk, author_fk) -- Compound key
) WITHOUT ROWID;

INSERT INTO book_authors VALUES
("1", "1"),
("2", "2");



-- #################################
-- Junction table for books and categories

DROP TABLE IF EXISTS book_categories;

PRAGMA foreign_keys = ON;

CREATE TABLE book_categories (
    book_fk         TEXT,
    category_fk     TEXT,
    FOREIGN KEY (book_fk) REFERENCES books(book_pk), 
    FOREIGN KEY (category_fk) REFERENCES categories(category_pk), 
    PRIMARY KEY (book_fk, category_fk) -- Compound key
) WITHOUT ROWID;

INSERT INTO book_categories VALUES
("1", "1"),
("2", "2");

-- #################################

-- Select from primary entities first
SELECT * FROM books;
SELECT * FROM publishers;
SELECT * FROM authors;
SELECT * FROM categories;

-- Then from junction and lookup tables
SELECT * FROM books_format;
SELECT * FROM book_authors;
SELECT * FROM book_categories;

-- #################################
-- Joins


-- Inner join - books and publishers
SELECT books.book_pk, books.book_name, publishers.publisher_name FROM books INNER JOIN publishers ON books.publisher_fk = publishers.publisher_pk;


-- Inner and left join - books, publishers and categories
SELECT books.book_pk, books.book_name, publishers.publisher_name, categories.category_name
FROM books
INNER JOIN publishers ON books.publisher_fk = publishers.publisher_pk
LEFT JOIN book_categories ON books.book_pk = book_categories.book_fk
LEFT JOIN categories ON book_categories.category_fk = categories.category_pk;


