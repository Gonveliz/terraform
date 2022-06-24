# variable "filename" {
#     type = map
#     default = {
#         perro = "/home/osboxes/repos/terraform/8/dogs.txt",
#         mascota = "/home/osboxes/repos/terraform/8/pets.txt",
#         gato = "/home/osboxes/repos/terraform/8/cats.txt"
#     }
# }
variable "instances" {
    type = map
    default = {
        instancia1 = "/home/osboxes/repos/terraform/8/rabbit.txt",
        instancia2 = "/home/osboxes/repos/terraform/8/pets.txt",
        instancia3 = "/home/osboxes/repos/terraform/8/cats.txt",
    }
}