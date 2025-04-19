# lens


Subir apenas a infra:

```docker-compose -f docker-compose.infra.yml up``` 

`find . -type f \( -name "*.go" -o  -name "*.jsx" -o -name "*.tsx" \) -exec wc -l {} + | awk '{s+=$1} END {print s}'`

O que devo mostrar:
* Testes em /home/saimon/Documents/Hubly/keeper/internal/app/mediator/template_test.go
* 