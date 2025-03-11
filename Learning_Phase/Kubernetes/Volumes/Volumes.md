# Understanding "State"
State is data created and used by your application which must not be lost </br>
Type of state
- User-generated data (ie. database)
- Temporary Data (ie. RAM)

# Kubernetes vs Docker Volumes
| Kubernetes Volumes | Docker Volumes |
|---|---|
| Supports many different Drivers and Types | no Driver/Type Support |
|Volumes aren't necessarily persistent | Volume persist until manually cleared |
Volumes survive after Container restarts and remove | Volumes survive after Container restarts and remove | 