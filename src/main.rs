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
    // mov ah, 0x09
    // Instructs BIOS to Write a character
    image.push(0xb4);
    image.push(0x09);
    // mov al, 0x41 aka 'A'
    // What character to print
    image.push(0xb0);
    image.push(0x41);
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
    let len = image.len();
    // Stuff 0s till 510th byte
    (len..0x1fe).for_each(|_| image.push(0));
    // Append Signature Bytes
    image.push(0x55);
    image.push(0xaa);
    output.write_all(&image).unwrap();
}
