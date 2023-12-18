## Access Amazon S3 bucket from Amazon EC2 instance using Terraform

<h6> Services Used</h6>

* Elastic Compute Service (EC2) 

* Simple Storage Servive (S3)

* Identity Access Manager (IAM)

<h6> Key concepts</h6>

* **for_each**
 
  - is meta-argument that accepts a map or set of strings and creates an instance for each item in that map or set. 

  * **Example:**

  ```
  resource "aws_iam_user" {
    for_each = toset(["Pierre" , "Jean" , "Ali"])

    # display the name of each IAM user
    name = each.key
  }
  ```

  * **fileset()**

    - is a function that enumerates a set of file names based on a given path and pattern.

    * **Example:**

  ```
  # display all files present in the data directory
  fileset("html/data" , "*")
  ```
