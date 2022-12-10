# Captura e análise de tráfego de rede de aplicação no servidor remoto

Acessar o ambiente desejado (teste, desenvolvimento, ou homologação) via VPN do ITA.

Iniciar a captura de tráfego de rede na aplicação e iniciar os textes via _browser_ (ou qualquer outro meio de comunicação utilizado para chegar na aplicação).

```sh
docker exec -it flualfagovbr tcpdump -i any -w /dist/flualfa/dump-$(date +%F-%H%M).pcap
```

Ao final do teste, interromper a captura e obter o arquivo gerado remotamente na pasta da aplicação vi *SFTP*.

Utilizando a sua ferramenta de análise predileta, analisar o tráfego gerado pelo teste:

![Análise com Wireshark](./images/01-wireshark.png)

> **Obs**.: para complementar pode ser interessante capturar o tráfego de rede na sua máquina local simultaneamente para poder comparar as mensagens enviadas com as recebidas pelo servidor. Isto pode ser feito diretamente pelo **Wireshark** (exemplo acima) enquanto executa a captura no servidor remoto.
