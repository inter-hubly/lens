# lens

Documentação https://silent-antimatter-538.notion.site/Hubly-1578902711f9809a8c6cc6c32cd24764?pvs=4


Subir apenas a infra:

```docker-compose -f docker-compose.infra.yml up``` 

`find . -type f \( -name "*.go" -o  -name "*.jsx" -o -name "*.tsx" \) -exec wc -l {} + | awk '{s+=$1} END {print s}'`

`docker stop $(docker ps -q) && docker rm $(docker ps -aq)`
O que devo mostrar:
* Testes em /home/saimon/Documents/Hubly/keeper/internal/app/mediator/template_test.go
* 