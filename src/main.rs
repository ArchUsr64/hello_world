#![feature(file_create_new)]

use std::{
    fs,
    io::{self, Read, Write},
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
    (0..0x1fe).for_each(|_| image.push(0));
    image.push(0x55);
    image.push(0xaa);
    output.write_all(&image).unwrap();
}
