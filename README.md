# Laboratório - Criação Pipeline de Dados (OCI Data Integration e OCI Data Flow)

## Roteiro
* [Provisionamento Workspace - OCI Data Integration](https://github.com/heloisaescobar/OCI-DI_Laboratorio/blob/main/README.md#provisionamento-workspace)
* [Provisionamento Data Flow - OCI Data Flow]
* [Preparação Procedure - Autonomous]
* [Montagem Pipeline]

## OCI Data Integration e Data Flow

<i>Pré Requisitos: Ter Compartimento Criado, VCN, Aplicar as [Policies](https://github.com/heloisaescobar/InLab-Pipeline-Dados-Aplicado-Eventos/blob/master/scripts_apoio/policies_anexo.txt)</i>.

### Provisionamento Workspace - OCI Data Integration

Expanda a lista de serviços da OCI utilizando o menu de hambúrguer, no canto superior esquerdo. Em seguida, clique em Analytics & AI e clique me Data Integration

![image](https://user-images.githubusercontent.com/46925501/155429984-23074dfd-a568-4474-bd97-fbb84aa25f3f.png)

Clique em <i>Create Workspace</i>

![image](https://user-images.githubusercontent.com/46925501/161565524-9048b915-44b0-489e-90ad-b53b643e4478.png)

Dê um nome ao Workspace, Descrição, clique em ‘Enable private Networking’ e selcione uma VCN e uma Subnet <i>PRIVADA</i>. Em seguida clique em <i>Create</i>.

![image](https://user-images.githubusercontent.com/46925501/161566794-3ef55c8f-874b-4169-9580-dea209d0aa01.png)

Após alguns minutos você verá seu workspace listado como <i>Active</i>.

![image](https://user-images.githubusercontent.com/46925501/161567062-5b837e0e-6dbc-4f7d-9c3e-e65e97ac5d32.png)

### Provisionamento Data Flow - OCI Data Flow

#### Validação Pré Requisitos

Antes de iniciarmos a criação e configuração do Data Flow, vamos validar se temos alguns pré requisitos disponíveis em nosso ambiente.
Entre os principais pré-requisitos do Data Flow, também temos alguns recursos necessários para a execução desta atividade, podemos destacar:
* Buckets utilizados pelo Data Flow;
* Buckets de input e outputs de dados;
* Identificação do Namespace do Object Storage;
* Download do script python de exemplo;
* Download do Dataset framingham.csv em formato csv.

<b>Verificação dos buckets necessários</b>

Nessa etapa, vamos validar a existência/criação dos seguintes buckets no Object Storage:
* dataflow-logs
* dataflow-app
* raw-data
* data-out

Utilizando o menu de hambúrgue, no canto superior esquerdo. Em seguida, clique em Storage e dentro de Object Storage & Archive clique em buckets

![image](https://user-images.githubusercontent.com/46925501/161979303-34ab0855-bd31-4528-9809-bb9e96a3408c.png)

Verifique ao lado esquerdo da tela se estamos com o Compartimento correto (DataAIFastTrack), devemos neste ponto visualizar todos os buckets listados acima

![image](https://user-images.githubusercontent.com/46925501/161979479-dc29b610-6919-4399-bd63-5d64c3c2d358.png)

<b>Identificação do Namespace do Object Storage</b>

Nesta etapa, vamos coletar o Namespace do Object Storage do seu ambiente. Está informação é de extrema relevância, pois será utilizada nas etapas de configuração do nosso script python.

Para visualizar e copiar o Namespace do seu ambiente, acesse o menu com seu avatar de usuário no canto superior direito, e clique no nome do seu Tenancy

![image](https://user-images.githubusercontent.com/46925501/161980114-8d3e4f5f-4d5e-4a3b-9096-ca7639d14507.png)

Agora nas informações do seu Tenancy, podemos encontrar e copiar o Object Storage Namespace.
<b>Atenção:</b> Guarde o nome do Namespace em um notepad ou editor de sua preferência.

![image](https://user-images.githubusercontent.com/46925501/161980488-b358577f-91c5-4d2f-982d-3e4c1cd68e82.png)

<b>Download dos Arquivos Utilizados</b>

Durante esse laboratório, iremos utilizar o script python <b>csv_to_parquet.py</b> e o dataset <b>framingham.csv</b>. Esses arquivos, você pode localizar no link abaixo:
####ADD LINK

<b>Configurando o Script Python</b>

Após o download dos arquivos no passo anterior, primeiramente vaoms trabalhar com o csv_to_parquet.py. Abra esse arquivo no edisto de texto de sua preferência.

Dentro do Script, localize a variável NAMESPACE.

Agora utilizaremos o namespace já identificado para adicionar o valor nessa variável

![image](https://user-images.githubusercontent.com/46925501/161981777-8b02de08-c59a-49fc-bd90-ac1904ae2082.png)
<b>Atenção:</b> Colocar o seu namespace entre "" (aspas duplas).

<b>Transferindo arquivos utilizados para o buckets</b>

Nessa etapa vamos utilizar a própria UI do OCI para fazer o upload dos arquivos para os buckets corretos no Object Storage.
Para realizar esta transferência devemos acessar o serviço do Object Storage a partir do menu de hamburguer no canto superior esquerdo.

![image](https://user-images.githubusercontent.com/46925501/161982297-84bcc358-43a9-4181-91ed-1994b9120cd9.png)

- Transferindo o dataset: framingham.csv

Nesse estágio vamos fazer o upload do dataset framingham.csv no bucket raw-data.

Para realizar o upload, acessar o bucket desejado (raw-data), clicar no botão UPLOAD e transferir o arquivo

![image](https://user-images.githubusercontent.com/46925501/161982891-7a5a21b6-cfa9-4816-b781-e9da4d438fd4.png)

![image](https://user-images.githubusercontent.com/46925501/161982940-15e448a9-9737-4fb7-bbda-2a13ecd63002.png)

- Transferindo o Script Python para o Bucket

Seguindo o mesmo procedimento executado para o upload do dataset, agora vamos transferir o script python com as alterações já realizadas csv_to_parquet.py para o bucket dataflow-app.

![image](https://user-images.githubusercontent.com/46925501/161983494-22b3aeff-7003-43c0-94f5-c765c0203ece.png)

![image](https://user-images.githubusercontent.com/46925501/161983508-7b1e5ee4-0e91-4a6a-807f-24feef39f456.png)

#### Provisionando sua Primeira Aplicação no OCI Data Flow

Neste passo iremos criar nossa primeira Aplicação no Data Flow. O objectivo desta aplicação será transformar o dataset framingham.csv em arquivo parquet, que poderá ser consumido por outras ferramentas.

Para acessarmos o Data Flow, cliquem no meu de hamburguer no canto superior esquerdo e depois acesse Analytics & IA > Data Flow

![image](https://user-images.githubusercontent.com/46925501/161983892-92c6826a-e222-47fa-af15-326f7c904539.png)

Dentro da console do Data Flow, vamos clicar em <i>Create Application</i>

![image](https://user-images.githubusercontent.com/46925501/161984259-9b0da753-65b3-4d65-a4c2-7ab0b9506963.png)

Após clicar no botão, iremos fornecer as informações necessárias para a criação da nossa aplicação

![image](https://user-images.githubusercontent.com/46925501/161984861-0887d50e-6642-470e-a0db-4b5c1bb433d7.png)

![image](https://user-images.githubusercontent.com/46925501/161985100-b9569f8e-7586-4d03-af64-86f5fc35647a.png)

![image](https://user-images.githubusercontent.com/46925501/161985176-8b80d4b7-27e9-4595-8f10-562dbd438aef.png)

![image](https://user-images.githubusercontent.com/46925501/161985196-a3ff6f0d-d010-456a-8057-c0d7848e63a2.png)

<b>Atenção:</b> Fizemos a criação da nossa aplicação spark, contudo não vamos executar ela nesse momento.

#### Preparação Procedure - Autonomous Data Warehouse

Antes de iniciarmos a criação do nosso pipeline de dados, vamos dar uma rápida passada por mais um serviço o Autonomous Data Warehouse. Nele além de utilizarmos para futuramente criarmos nossa tabelas de destino, vamos também criar um procedure para armazenamento de resultados de sucesso e erro do nosso pipeline de dados desenvolvido no OCI Data Integration.

Para acessar o Autonomous Data Warehouse, clique no menu de hamburguer > Oracle Database > Autonomous Data Warehouse

![image](https://user-images.githubusercontent.com/46925501/161987497-db56c6df-7a86-4649-bb02-c717a5a5b88e.png)

Em seguida, clique sobre o nome da instância de Autonomous Data Warehouse que você tenha disponível

![image](https://user-images.githubusercontent.com/46925501/161987942-bc8dd58b-8254-4129-b3dc-dc9d0d3b0f43.png)

Você será redirecionado para uma janela com os detalhes da instância de Autonomous Data Warehouse. Nesta tela clique sobre o botão Database Actions

![image](https://user-images.githubusercontent.com/46925501/161988328-3ce4a839-174b-4a2d-8e5a-25502b14a612.png)

Você será direcionado para uma nova console. Cliquem em SQL

![image](https://user-images.githubusercontent.com/46925501/161988543-3bf581b1-c1ec-4a95-bf54-52964981cf47.png)

Copiar o conteúdo do arquivo procedure_status.sql, copiar no worksheet e clique no botão executar

![image](https://user-images.githubusercontent.com/46925501/161990817-d67d68b9-7b92-4830-8f22-43eeea4bc3bd.png)

Verificar se os comandos foram executaos com sucesso.

<b>Atenção:</b> Fizemos a criação da nossa tabela para registro do nosso pipeline e a procedure, contudo não vamos utilizar elas nesse momento.

_________________
### Criação dos Data Assets

<b>Criando o Data Asset do Autonomous Data Warehouse</b>

Pré-requisito: Ter um Autonomous Data Warehouse provisionado, ter um usuário com privilégios DBMS_CLOUD e DWROLE. Para provisionar o Autonomous [clique aqui](https://github.com/heloisaescobar/InLab-Pipeline-Dados-Aplicado-Eventos#autonomous-data-warehouse)

Antes começarmos a criação do Data Asset do Oracle Autonomous Data Warehouse nós precisamos salvar a Wallet de acesso ao banco. Para isso siga os passos abaixo:
Expanda a lista de serviços da OCI utilizando o menu de hambúrguer, no canto superior esquerdo. Em seguida, selecione Oracle Database e clique em Autonomous Data Warehouse.

![image](https://user-images.githubusercontent.com/46925501/155430296-1fc6b6be-c5a3-47e8-9108-c4cb1776f376.png)

Em seguida, clique sobre o nome da instância de Autonomous Data Warehouse que você tenha disponível (pré-requisito)

![image](https://user-images.githubusercontent.com/46925501/161569330-7b917faa-c748-40da-ad99-5243dd606613.png)

Você será redirecionado para uma janela com os detalhes da instância de Autonomous Data Warehouse. Nesta tela clique sobre o botão DB Connection.

![image](https://user-images.githubusercontent.com/46925501/161569598-8ab556b7-87fb-42a4-8803-8638172c36d4.png)

Uma caixa de diálogo será exibida. Nesta, clique em Download Wallet.

![image](https://user-images.githubusercontent.com/46925501/155430342-6432977a-da15-45ec-aecc-a902c17bf714.png)

Digite uma senha de sua preferência, clique em Download e salve o arquivo .zip em uma pasta desejada.

![image](https://user-images.githubusercontent.com/46925501/155430352-6ca40330-33c3-42ee-9a30-4a02befa546f.png)

Acesse a aba do OCI Data Integration:

![image](https://user-images.githubusercontent.com/46925501/155430369-d5144133-97da-4d7b-be95-7cdb96556074.png)

E selecione o Workspace que foi criado durante a parte de preparação do ambiente:

![image](https://user-images.githubusercontent.com/46925501/161567062-5b837e0e-6dbc-4f7d-9c3e-e65e97ac5d32.png)

Clique no sinal de <b>+</b> e em seguida clique em Data Assets

![image](https://user-images.githubusercontent.com/46925501/155430452-cbc4d61f-d6f9-4dd3-96e8-f19c10457026.png)

Clique em Create Data Asset, você pode observar que uma nova aba chamada Create Data Asset foi aberta.

![image](https://user-images.githubusercontent.com/46925501/155430469-201cf816-1e80-4441-a219-72976c0b40eb.png)

Dê o nome ao Data Asset <i>DA_ADW01</i> (como na imagem) e selecione o Type como Oracle Autonomous Data Warehouse.

![image](https://user-images.githubusercontent.com/46925501/155430490-75e71c87-ae4b-4444-9224-6c2f87f27f46.png)

Mais abaixo, na mesma página mantenha o botão de rádio Upload Wallet selecionado., clique em Select File e localize o arquivo .zip que você fez o download anteriormente. Faça a carga do arquivo .zip, insira a senha do .zip e escolha o Service Name <b>(<nome_do_ADW>.medium)</b>

![image](https://user-images.githubusercontent.com/46925501/155430535-0d260919-2398-44e5-832c-75601b5f8655.png)

Deixe a opção Default Connection no Name e Identifier. Em seguida coloque o User name e Password fornecido na criação do banco de dados.
  
Clique em Teste Connection, se a conexão for bem sucedida clique no botão <i>Create</i>.

![image](https://user-images.githubusercontent.com/46925501/155430632-78dc0791-c3e1-4fb5-84f6-34d01e263b0e.png)

Pronto você criou um Data Asset do Oracle Autonomous Data Warehouse.

<b>Criando o Data Asset do Object Storage</b>
  
Retorne para a aba do OCI Data Integration

![image](https://user-images.githubusercontent.com/46925501/155430849-aaadbef9-866c-4234-aa3b-bee93b6c806e.png)

E selecione o Workspace que foi criado durante a parte de preparação do ambiente.
  
![image](https://user-images.githubusercontent.com/46925501/161567062-5b837e0e-6dbc-4f7d-9c3e-e65e97ac5d32.png)

Clique no sinal de <b>+</b> e em seguida clique em Data Assets

![image](https://user-images.githubusercontent.com/46925501/155430906-238282a3-7fea-4829-8ded-626827d63679.png)

Clique em Create Data Asset, você pode observar que uma nova aba chamada Create Data Asset foi aberta.

![image](https://user-images.githubusercontent.com/46925501/155430929-cc3e81d7-0641-459f-88a0-81a69a70bde6.png)

Dê o nome ao Data Asset “DA_OBJstorage” (como na imagem) e selecione o Type como Oracle Object storage

![image](https://user-images.githubusercontent.com/46925501/155430952-90c03e17-a0bb-420d-8760-279dbd0ce87d.png)

Nesta fase, necessitamos de algumas informações que estão distribuídas na console da OCI. Duplique a aba do seu navegador para navegar pelas próximas páginas. Primeiro precisaremos da “tenancy OCID” em seguida o Namespace do Object Storage.

Na aba duplicada, no o canto superior direito clique na figura humana e, em seguida, clique em Tenancy.
  
![image](https://user-images.githubusercontent.com/46925501/161623563-900a6e03-8230-4cc2-8d25-a383893807bf.png)

Uma tela com os detalhes da Tenancy será exibida. Localize o campo OCID e clique em Copy.
  
![image](https://user-images.githubusercontent.com/46925501/161624072-3d7bc5e3-e421-43ba-96cc-6731a8e8194e.png)

Reserve esse ID da tenancy, em seguida copie e reserve o identificador do Namespace do Object Storage.

Retorne à aba do OCI Data Integration em que está criando o data asset do Object Storage e insira os valores copiados no campo Tenant OCID e Namespace. (Geralmente o campo Namespace é preenchido automaticamente após você colocar o OCID da tenancy, mas caso isso não ocorra cole o Namespace que você salvou no passo anterior)
A ultima informação necessário para configurarmos o Data Asset do Object Storage é o identificador da sua Region, você vai encontra-lo em sua URL como representado no imagem abaixo

![image](https://user-images.githubusercontent.com/46925501/155431089-7885a910-d1db-4b0d-a0b9-8139baa736f8.png)
  
Agora preencha as informações conforme a imagem abaixo:

![image](https://user-images.githubusercontent.com/46925501/161624619-7d3e88e2-9efc-49b5-91a0-60376dc1fb80.png)

Mantenha as opções de Connection como estão e clique em Test Connection.
Se conexão for bem sucedida clique em Create:
![image](https://user-images.githubusercontent.com/46925501/155431192-ee12bbbf-6093-495a-8bd6-f9ca5c430ad2.png)

Você finalizou a criação dos Data Assets!

