resource "aws_instance" "instance" {
  ami                     = data.aws_ami.centos.image_id
  instance_type           = var.instance_type
  vpc_security_group_ids  = [data.aws_security_group.allow-all.id]

  tags = {
    Name = local.name
  }
}

resource "null_resource" "provisioner" {
  depends_on = [aws_instance.instance,aws_route53_record.DNS_Records]
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "centos"
      password = "DevOps321"
      host = [aws_instance.instance.private_ip]
    }

    inline = [
      "rm -rf Roboshop-shell-practice",
      "https://github.com/Sreeni002/Roboshop-shell-practice.git",
      "cd Roboshop-shell-practice",
      "sudo bash ${var.component_name}.sh ${var.password}"
    ]
  }
}

resource "aws_route53_record" "DNS_Records" {
  zone_id = "Z07549141EOZGRX0U9S5Y"
  name    = "${var.component_name}-dev.sreenivasulareddydevops.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}
