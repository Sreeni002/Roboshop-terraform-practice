data "aws_ami" "centos" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}

data "aws_security_group" "allow-all" {
  name = "allow-all"
}

#variable "instance_type" {
#  default = "t3.small"
#}

variable "component" {
  #default = ["frontend","mongodb","catalogue"]
  default = {
    frontend = {
      name = "frontend"
      instance_type = "t3.small"
    }
    mongodb = {
      name = "mongodb"
      instance_type = "t3.micro"
    }
    catalogue = {
      name = "catalogue"
      instance_type = "t3.small"
    }
    redis = {
      name = "redis"
      instance_type = "t3.small"
    }
    user = {
      name = "user"
      instance_type = "t3.small"
    }
    cart = {
      name = "cart"
      instance_type = "t3.micro"
    }
    mysql = {
      name = "mysql"
      instance_type = "t3.small"
    }
    rabbitmq = {
      name = "rabbitmq"
      instance_type = "t3.small"
    }
    payment = {
      name = "payment"
      instance_type = "t3.medium"
    }
    shipping = {
      name = "shipping"
      instance_type = "t3.medium"
    }
  }
}

resource "aws_instance" "instance" {
  for_each = var.component
#  count = length(var.component)
  ami           = data.aws_ami.centos.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route53_record" "DNS_Records" {
  for_each = var.component
  zone_id = "Z07549141EOZGRX0U9S5Y"
  name    = "${each.value["name"]}-dev.sreenivasulareddydevops.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[each.value["name"]].private_ip]
}

#resource "aws_instance" "mongodb" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "mongodb"
#  }
#}
#
#resource "aws_route53_record" "mongodb" {
#  zone_id = "Z07549141EOZGRX0U9S5Y"
#  name    = "mongodb-dev.sreenivasulareddydevops.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.mongodb.private_ip]
#}
#
#resource "aws_instance" "catalogue" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "catalogue"
#  }
#}
#
#resource "aws_route53_record" "catalogue" {
#  zone_id = "Z07549141EOZGRX0U9S5Y"
#  name    = "catalogue-dev.sreenivasulareddydevops.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.catalogue.private_ip]
#}
#
#resource "aws_instance" "redis" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "redis"
#  }
#}
#
#resource "aws_route53_record" "redis" {
#  zone_id = "Z07549141EOZGRX0U9S5Y"
#  name    = "redis-dev.sreenivasulareddydevops.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.redis.private_ip]
#}
#
#resource "aws_instance" "user" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "user"
#  }
#}
#
#resource "aws_route53_record" "user" {
#  zone_id = "Z07549141EOZGRX0U9S5Y"
#  name    = "user-dev.sreenivasulareddydevops.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.user.private_ip]
#}
#
#resource "aws_instance" "cart" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "cart"
#  }
#}
#
#resource "aws_route53_record" "cart" {
#  zone_id = "Z07549141EOZGRX0U9S5Y"
#  name    = "cart-dev.sreenivasulareddydevops.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.cart.private_ip]
#}
#
#resource "aws_instance" "mysql" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "mysql"
#  }
#}
#
#resource "aws_route53_record" "mysql" {
#  zone_id = "Z07549141EOZGRX0U9S5Y"
#  name    = "mysql-dev.sreenivasulareddydevops.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.mysql.private_ip]
#}
#
#resource "aws_instance" "shipping" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "shipping"
#  }
#}
#
#resource "aws_route53_record" "shipping" {
#  zone_id = "Z07549141EOZGRX0U9S5Y"
#  name    = "shipping-dev.sreenivasulareddydevops.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.shipping.private_ip]
#}
#
#resource "aws_instance" "rabbitmq" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "rabbitmq"
#  }
#}
#
#resource "aws_route53_record" "rabbitmq" {
#  zone_id = "Z07549141EOZGRX0U9S5Y"
#  name    = "rabbitmq-dev.sreenivasulareddydevops.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.rabbitmq.private_ip]
#}
#
#resource "aws_instance" "payment" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "payment"
#  }
#}
#
#resource "aws_route53_record" "payment" {
#  zone_id = "Z07549141EOZGRX0U9S5Y"
#  name    = "payment-dev.sreenivasulareddydevops.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.payment.private_ip]
#}