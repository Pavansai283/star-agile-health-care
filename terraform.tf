
provider "aws" {
   region="ap-south-1"
     access_key="AKIAZAWABVFBJKK2F74Z"
     secret_key="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"
  }

resource "aws_instance" "Prod-Server" {
  ami                    = "ami-02eb7a4783e7e9317"
  instance_type          = "t2.medium"
  availability_zone      = "ap-south-1a"
  vpc_security_group_ids = ["sg-01714141887774176"]
  key_name               = "myEC2key.pem"
  tags = {
    name = "k8s_instance"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install docker.io -y",
      "sudo wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64",
      "sudo chmod +x /home/ubuntu/minikube-linux-amd64",
      "sudo cp minikube-linux-amd64 /usr/local/bin/minikube",
      "curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl",
      "sudo chmod +x /home/ubuntu/kubectl",
      "sudo cp kubectl /usr/local/bin/kubectl",
      "sudo usermod -aG docker ubuntu"
    ]
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("./myEC2key.pem")
    }
  }
}
