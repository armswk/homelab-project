helm chart = package manager, docker build
Helm Chart Structure </br>
Project name </br>
&ensp;    |_ templates # Templates directory </br>
&ensp;    |_ values.yaml # Configurable Values </br>
&ensp;    |_ Chart.yaml # Chart Information</br>
&ensp;    |_ LICENSE # Chart License</br>
&ensp;    |_ README.md # Readme file</br>
&ensp;    |_ charts # Dependency chart</br>

helm pull untar <"repo-name">