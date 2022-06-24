resource "local_file" "pet" {
  filename = var.filename
  # file_permission = "0777"
  content = var.content
}