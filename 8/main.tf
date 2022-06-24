resource "local_file" "pet" {
  for_each = var.filename
  filename = each.value
  content = each.key
}