# Input Variables
Customize values based on variables to create reusable and composable code

### Motivation for input variables:
- To be able to customize aspects of terraform configurations and modules without having to alter the source code

### Notes around variables:
- declare them inside of 'variables.tf' and then use 'var.<name>'
- all the sensitive data aren't shown in the cli except can be inspect in the tfstate file