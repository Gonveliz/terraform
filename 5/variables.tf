variable "filename" {
    type = set(string)
    default = [
        "/home/osboxes/repos/terraform/5/dogs.txt",
        "/home/osboxes/repos/terraform/5/pets.txt",
        "/home/osboxes/repos/terraform/5/cats.txt"
    ]
}
