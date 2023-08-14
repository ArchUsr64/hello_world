#![feature(file_create_new)]

use std::{
    fs,
    io::{self, Write},
};
const OUT_PATH: &'static str = "hello_world.img";

fn main() {
    let output = &mut loop {
        match fs::File::create_new(OUT_PATH) {
            Ok(file_stream) => break file_stream,
            Err(e) => match e.kind() {
                io::ErrorKind::AlreadyExists => {
                    eprintln!("'{OUT_PATH}' already exists, will be removed!");
                    fs::remove_file(OUT_PATH).unwrap();
                    continue;
                }
                _ => panic!("{e:?}"),
            },
        }
    };
    let mut image = Vec::<u8>::new();

    let mut print_char = |position, char| {
        // mov ah, 0x09
        // Instructs BIOS to change position of cursor
        image.push(0xb4);
        image.push(0x02);
        // mov bh, 0x01
        // Which page number to set the cursor to
        image.push(0xb7);
        image.push(0x00);
        // mov dh, [position]
        // Sets the row for the cursor
        image.push(0xb6);
        image.push(0x00);
        // mov dl, 0x00
        // Sets the column for the cursor
        image.push(0xb2);
        image.push(position);
        // int 0x10
        image.push(0xcd);
        image.push(0x10);
        // mov ah, 0x09
        // Instructs BIOS to Write a character
        image.push(0xb4);
        image.push(0x09);
        // mov al, [Input character in ASCII]
        // What character to print
        image.push(0xb0);
        image.push(char as u8);
        // mov cl, 0x05
        // How many times should a character be printed
        image.push(0xb1);
        image.push(0x01);
        // mov bl, 0x01
        // Sets color of text
        image.push(0xb3);
        image.push(0x0f);
        // mov bh, 0x01
        // Which page number to display the character on
        image.push(0xb7);
        image.push(0x00);
        // int 0x10
        image.push(0xcd);
        image.push(0x10);
    };
    "Hello World!"
        .chars()
        .enumerate()
        .for_each(|(position, char)| {
            print_char(position as u8, char);
        });
    let len = image.len();
    // Stuff 0s till 510th byte
    (len..0x1fe).for_each(|_| image.push(0));
    // Append Signature Bytes
    image.push(0x55);
    image.push(0xaa);
    output.write_all(&image).unwrap();
}
