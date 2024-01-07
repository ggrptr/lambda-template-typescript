variable "lambda" {
  type = object({
    function_name = string
    package       = string
    runtime       = optional(string,"nodejs20.x")
    handler       = optional(string,"main.handler")
    timeout       = optional(number,5)
    memory_size   = optional(number,128)
    additional_layers = optional(map(string),{})
  })
}