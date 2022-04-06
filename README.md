# Laboratório - Criação Pipeline de Dados (OCI Data Integration e OCI Data Flow)

## Roteiro
* [Provisionamento Workspace - OCI Data Integration](https://github.com/heloisaescobar/OCI-DI_Laboratorio/blob/main/README.md#provisionamento-workspace)
* [Provisionamento Data Flow - OCI Data Flow](https://github.com/heloisaescobar/OCI-DI_Laboratorio/blob/main/README.md#provisionamento-data-flow---oci-data-flow)
* [Preparação Procedure - Autonomous](https://github.com/heloisaescobar/OCI-DI_Laboratorio#prepara%C3%A7%C3%A3o-procedure---autonomous-data-warehouse)
* [Montagem Pipeline - OCI Data Integration](https://github.com/heloisaescobar/OCI-DI_Laboratorio#montagem-pipeline---oci-data-integration)
* [Tópico Bonus - Scheduler]

## OCI Data Integration e Data Flow

<i>Pré Requisitos: Ter Compartimento Criado, VCN, Aplicar as [Policies](https://github.com/heloisaescobar/OCI-DI_Laboratorio/blob/main/arquivos_apoio/policies.txt)</i>.

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
* Download do script python de exemplo [csv_to_parquet.py](https://github.com/heloisaescobar/OCI-DI_Laboratorio/blob/main/arquivos_apoio/csv_to_parquet.py);
* Download do Dataset [framingham.csv](https://github.com/heloisaescobar/OCI-DI_Laboratorio/blob/main/arquivos_apoio/framingham.csv) em formato csv.

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

Durante esse laboratório, iremos utilizar o script python <b>csv_to_parquet.py</b> e o dataset <b>framingham.csv</b>. Esses arquivos, você pode localizar [AQUI](https://github.com/heloisaescobar/OCI-DI_Laboratorio/tree/main/arquivos_apoio)

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

<b>Executando a Aplicação</b>
Após a criação da sua aplicação no OCI Data Flow, agora podemos executar o código quantas vezes necessário através do botão RUN na console.
![image](https://user-images.githubusercontent.com/46925501/162047955-552a9d19-7df1-4df2-affd-9dc6f8c841e2.png)

Para cada execução podemos definir individualmente os parâmetros relacionados a infraestrutura alocada ou argumentos.
Para executarmos, vamos clicar em <i>RUN</i>
![image](https://user-images.githubusercontent.com/46925501/162048355-7e7046de-ce3b-4b5e-a27e-7451342c7161.png)

Vamos manter as configurações já configuradas na própria aplicação e clica em <i>RUN</i>
![image](https://user-images.githubusercontent.com/46925501/162048570-0d850690-c3e6-4ea8-bb5a-6c503906da96.png)

Você será direcionado para a aplicação que está sendo executada e poderá acompanhar o processo de execução
![image](https://user-images.githubusercontent.com/46925501/162048818-89d4de6a-5c69-4eee-ad68-8556a7dd503d.png)


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

### Montagem Pipeline - OCI Data Integration

Nessa etapa, vamos utilizar todos os passos anteriores para criar nosso pipeline de dados.

##### Criação dos Data Assets

Expanda a lista de serviços da OCI utilizando o menu de hambúrguer, no canto superior esquerdo. Em seguida, clique em Analytics & AI e clique me Data Integration

![image](https://user-images.githubusercontent.com/46925501/161991683-7ec748f1-edf6-4c51-96d4-95c332c1d14c.png)

Selecion o Workspace que criamos nos primeiros passos

![image](https://user-images.githubusercontent.com/46925501/161991818-6f4ac7df-623b-4940-a5e9-9150a1d8681e.png)

<b>Criando o Data Asset do Autonomous Data Warehouse</b>

Pré-requisito: Ter um Autonomous Data Warehouse provisionado, ter um usuário com privilégios DBMS_CLOUD e DWROLE.

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

##### Criação Tarefa OCI Data Flow
  
Nessa fase vamos configurar a nossa aplicação criada no OCI Data Flow para que seja executado no nosso pipeline de dados dentro do OCI Data Integration.
  
Dentro no nosso workspace, clicar em <b>+</b> e em seguida clique em <i>Projects</i>
  
![image](https://user-images.githubusercontent.com/46925501/161994564-242b0d37-d0b9-458f-ad53-9e0def67b864.png)

Acesse seu projeto
  
![image](https://user-images.githubusercontent.com/46925501/161994961-5d239dc7-694c-4222-852c-0929609c8d79.png)

Clique em <i>Tasks</i>

![image](https://user-images.githubusercontent.com/46925501/161995356-1f966482-dfa9-4bb7-b2c7-56b870b18795.png)

![image](https://user-images.githubusercontent.com/46925501/161995722-45c93437-8e74-4fde-96f8-7416c0f91fee.png)
  
Agora preenchemos o formulário, conforme abaixo
 
![image](https://user-images.githubusercontent.com/46925501/161996098-4254ba8a-8f22-4b0b-bc85-490fdb7c47d7.png)
![image](https://user-images.githubusercontent.com/46925501/161996248-7589fa29-f5e3-4212-8e04-f59cd620a846.png)
![image](https://user-images.githubusercontent.com/46925501/161996691-9dbf2280-b130-4b2f-bb79-b59977c60249.png)
![image](https://user-images.githubusercontent.com/46925501/161996891-bd208965-5ce8-4ecc-bb8b-3e45e6e469ce.png)
![image](https://user-images.githubusercontent.com/46925501/161997141-6742625c-cca6-417d-abd5-9453cbe03ef2.png)
![image](https://user-images.githubusercontent.com/46925501/161997330-31171734-e55d-47b1-a314-66a95c0f5382.png)

<b>Atenção</b> Criamos com sucesso nossa tarefa OCI Data Flow.
  
##### Criação Chamada Procedure

Nessa fase vamos configurar a nossa procedure criada no Autonomous Data Warehouse para que seja executado no nosso pipeline de dados dentro do OCI Data Integration.
  
Dentro no nosso workspace, clicar em <b>+</b> e em seguida clique em <i>Projects</i>
  
![image](https://user-images.githubusercontent.com/46925501/161994564-242b0d37-d0b9-458f-ad53-9e0def67b864.png)

Acesse seu projeto
  
![image](https://user-images.githubusercontent.com/46925501/161994961-5d239dc7-694c-4222-852c-0929609c8d79.png)

Clique em <i>Tasks</i>

![image](https://user-images.githubusercontent.com/46925501/161995356-1f966482-dfa9-4bb7-b2c7-56b870b18795.png)

![image](https://user-images.githubusercontent.com/46925501/161998325-124616d2-9529-43ea-8144-af1930821357.png)

Agora preenchemos o formulário, conforme abaixo

![image](https://user-images.githubusercontent.com/46925501/161998637-163fc1f8-2c64-4131-971d-def6dbbe4a87.png)
![image](https://user-images.githubusercontent.com/46925501/161998767-6d63a988-4c4a-4a3b-bf8e-98e71833cbd5.png)
![image](https://user-images.githubusercontent.com/46925501/161999322-326298f7-03a8-4e73-91c3-189374873fcd.png)
![image](https://user-images.githubusercontent.com/46925501/161999454-e37085ca-813e-4238-ad4a-08992fa98010.png)
![image](https://user-images.githubusercontent.com/46925501/162000119-21cb8bfd-48fb-42b1-a1ce-eeda9ed5f7ea.png)
![image](https://user-images.githubusercontent.com/46925501/161999978-15448db6-ecd3-4695-85f0-76a2effab1c0.png)
![image](https://user-images.githubusercontent.com/46925501/162000270-256aab45-0157-4b3c-acaf-2e0064e3aab5.png)

<b>Atenção:</b> Criamos com sucesso nossa tarefa SQL para chamada da Procedure

##### Criação e Configuração do Data Flow Designer

Nessa fase vamos configurar mais um passo do nosso fluxo dados, trabalhando o parquet que vamos gerar a partir da nossa aplicação OCI Data Flow para que seja executado no nosso pipeline de dados dentro do OCI Data Integration.
 
Clique no sinal de <b>+</b> e em seguida clique em Projects
  
![image](https://user-images.githubusercontent.com/46925501/162002747-287a1cd6-f5d6-4d6b-b461-ce4239670b97.png)

Selecione a guia Data Flow na lateral esquerda e em seguida clique em Create Data Flow
  
![image](https://user-images.githubusercontent.com/46925501/162002930-8dc3bec9-7275-4425-b913-ccf2195f5180.png)
  
<b>Configurações do Data Flow</b>
  
Com o canvas do Data Flow aberto vamos fazer o desenho do fluxo de dados e configurar cada um dos operadores.
 
Na tela do Data Flow desing, no painel de <i>Properties</i>, dê um nome ao Data Flow e verifique se o projeto correto está selecionado.

![image](https://user-images.githubusercontent.com/46925501/162003955-86e2bb56-d59b-4a5c-b9a9-afe35fc195b3.png)

<b>Configuração Operador Source</b>
 
Em seguida vamos começar a criação do Fluxo de Dados.
  
Clique no Painel Operators e arraste um Operador de Source(Fonte) e um de Target(Destino)
 
![image](https://user-images.githubusercontent.com/46925501/162004370-1720b12f-d008-4710-ab0f-4cd90a771239.png)

Clique no Operador Source que você arrastou até o Canvas do Data Flow, em seguida no Painel Properties, dê um nome ao Operador
  
![image](https://user-images.githubusercontent.com/46925501/162004680-a9013013-5cbe-4f43-8f4c-ff02f1463001.png)

Agora vamos configurar cada propriedade indicada no painel Properties: Data Asset, Connection, Schema e Data Entity
  
![image](https://user-images.githubusercontent.com/46925501/162007598-10021ea0-792c-4776-8190-d98f74101f41.png)

<b>Configuração Operador Target</b>
  
Clique no Operador Target que você arrastou até o Canvas do Data Flow, em seguida no Painel Properties dê um nome ao Operador. Em Integration Strategy selecione a opção Insert e habilite e opção <i>Create New Data Entity</i>

![image](https://user-images.githubusercontent.com/46925501/162008391-905b29c2-085b-4d84-96b7-e60030ad0a43.png)

Agora vamos configurar cada propriedade indicada no painel Properties: Data Asset, Connection, Schema, Data Entity e Staging Location. O processo é bem semelhante as configurações do Source Operator.
Teremos um resultado similar a imagem abaixo

![image](https://user-images.githubusercontent.com/46925501/162009071-acd51380-deb1-4d76-8f42-a3b78f70a2ae.png)
  
Adicionei mais um operador Target no canvas da Data Flow e realize as configurações semelhantes ao anterior, contudo mudando o nome do Operador e do Data Entity

![image](https://user-images.githubusercontent.com/46925501/162009510-52d07c1f-c59b-48a8-841a-f76dff4b9e28.png)

<b>Configurando os Shaping Operators</b>
  
Coloque no Canvas um Operador Expression e dois operadores Filter.
  
Após arrastar os Operadores conecte cada um deles conforme a Imagem Abaixo

![image](https://user-images.githubusercontent.com/46925501/162010162-7a4170ba-a882-437c-ba02-466e0885eb8d.png)

<b>Obs.</b> Para conectar os Operadores basta descansar o mouse sobre o operador até que uma bolinha apareça no lado diretor do operador, após isso basta clicar na bolinha e arrastar a linha até o operador que você deseja fazer a conexão:
![image](https://user-images.githubusercontent.com/46925501/162010555-d5177383-063d-4e85-b7d5-bda70063c745.png)

* Configurando o Operador Expression
Clique no Operador Expression que você arrastou até o Canvas do Data Flow, em seguida no Painel Properties dê um nome ao Operador e Clique em Add Expression
  
![image](https://user-images.githubusercontent.com/46925501/162011209-43df9649-1927-4bfe-ba0d-fc6f909e6e2e.png)

Preencha os Campos de Acordo com a Imagem e depois clique em Add
![image](https://user-images.githubusercontent.com/46925501/162011509-ed4ef284-6ec0-4c6b-b658-3b2ffb1737f4.png)

Adicionei outra linha no Operador Expression, preencha os campos de acordo com a Imagem e depois clique em Add
![image](https://user-images.githubusercontent.com/46925501/162011808-54fea897-a941-43fd-9ed1-eb51d328044c.png)

* Configurando o Operador Filter

Clique no Primeiro Operador Filter que você arrastou até o Canvas do Data Flow, em seguida no Painel Properties dê um nome ao Operador e Clique em Create
  
![image](https://user-images.githubusercontent.com/46925501/162012368-2220089e-290e-452f-b50a-017509d2f548.png)
  
Preencha conforme formulário abaixo
  
![image](https://user-images.githubusercontent.com/46925501/162012576-05d19198-bcd4-4912-9bbf-2def4bfee36c.png)
  
Clique no Segundo Operador Filter que você arrastou até o Canvas do Data Flow, em seguida no Painel Properties dê um nome ao Operador e Clique em Create

![image](https://user-images.githubusercontent.com/46925501/162012882-01b3b3fd-bf4e-48eb-8b86-ce1423b7b026.png)

Preencha conforme formulário abaixo
![image](https://user-images.githubusercontent.com/46925501/162013051-1ad90770-5678-49dd-9602-59b081c1954d.png)

Pronto! Todos os Operadores do Data Flow Designer estão configurado, clique em Save and Close.

<b>Criação do Integration Tasks</b>
  
Nessa sessão vamos criar e configurar uma Integration Task
  
Clique no sinal de <b>+</b> e selecione Application

![image](https://user-images.githubusercontent.com/46925501/162029091-894c3651-4234-48f0-922b-ec68cc2926e8.png)

Toda Integration Task deverá ser publicada aqui nessa Application. Agora continue para a peóxima sessão.
  
<b>Criando Integration Task</b>

Clique no sinal de + e em seguida clique em Projects

![image](https://user-images.githubusercontent.com/46925501/162029468-bf91ec4c-eac8-4a4e-8ab0-ab77a21ffcd4.png)

Selecione seu projeto e em seguida em Task, clique em <i>Create Task</i> e escolha a opção <i>Integration</i>

![image](https://user-images.githubusercontent.com/46925501/162029998-c3c282c6-8bd0-4eec-b5f0-3cd3c8aeaf32.png)
  
Dê um nome a <i>Integration Task</i> e verifique se o seu projeto está selecionado, em seguida clique no botão <i>Select</i> para selecionar o Data Flow que será usado na Task
![image](https://user-images.githubusercontent.com/46925501/162030481-5f3b372a-85ee-4fe7-aa15-28fca49e7dfd.png)

Selecione o Data Flow que criamos na seção anterior e clique em Select
![image](https://user-images.githubusercontent.com/46925501/162030704-3a050483-f8db-4540-9c38-ae5fe73bd4a4.png)
  
Aguarde a validação e clique em <b>Create and Close</b>
![image](https://user-images.githubusercontent.com/46925501/162031131-05561f1e-072d-451a-9953-7ebb0156e61d.png)

<b>Publicando a Aplicação</b>
Clique no sinal de + e em seguida clique em Projects

![image](https://user-images.githubusercontent.com/46925501/162029468-bf91ec4c-eac8-4a4e-8ab0-ab77a21ffcd4.png)
  
Selecione seu projeto e em seguida em Task. Selecione todos as tarefas que criamos até o momento e cliquem em <i>Publish to application</i>
![image](https://user-images.githubusercontent.com/46925501/162032167-70b9a2f3-c238-4a2b-8163-59df72345488.png)

Selecione a sua aplicação e cliquem em <i>Publish</i>
![image](https://user-images.githubusercontent.com/46925501/162032403-2d0b311c-a2ec-4917-abf5-6f244164db9a.png)

Agora clique no sinal <b>+</b> e selecione Application

![image](https://user-images.githubusercontent.com/46925501/162032721-9451b3d1-9770-4b15-9124-dcfee96f9450.png)

Acesse o <i>Default Application</i> que está disponível no seu Workspace
![image](https://user-images.githubusercontent.com/46925501/162032940-f2f5842d-1156-4f88-8a80-69307a168c20.png)

Ao acessar a <i>Application</i> você vai localizar as Integrations Task que publicamos na seção anterior
![image](https://user-images.githubusercontent.com/46925501/162033248-5acfeb5f-9c97-4b82-87ed-e2f1f743714c.png)
  
#### Criando e Configurando o Pipeline de Dados

Nessa fase vamos criar e configurar nosso pipeline completo de dados.

Dentro no nosso workspace, clicar em + e em seguida clique em Projects
![image](https://user-images.githubusercontent.com/46925501/162034841-7a84e13a-1201-46c8-b947-2cee7360e9fe.png)

Acesse seu projeto
![image](https://user-images.githubusercontent.com/46925501/162034935-957addcc-9cdb-4072-8a07-28c9c01639d6.png)

Clique em Pipelines
![image](https://user-images.githubusercontent.com/46925501/162035455-3b1d38d7-edc2-4b47-9040-e013f4d79804.png)

<b>Criando o Pipeline</b>
Com o canvas do Pipeline é bem parecido com o Canvas da Data Flow, a diferença é que agora temos operadores que vão chamar as tarefas que criamos nos passos anteriores.
  
Na tela do Pipeline desing, no painel de Properties, dê um nome ao Pipeline e verifique se o projeto correto está selecionado.
![image](https://user-images.githubusercontent.com/46925501/162035992-3de87996-f3ba-4cbf-87c3-44cde9e6e32f.png)

<b>Configurando os Operadores</b>

* OCI DATA FLOW
Vamos iniciar configurando o Operação de Chamada do OCI Data Flow, para isso selecione o Operador <i>OCI DATA FLOW</i> e interligue ao operador START conforme imagem
  
![image](https://user-images.githubusercontent.com/46925501/162036447-385e422a-15a8-461d-945c-0c6c15eb0566.png)
  
Clique com o botão direito sobre o operador OCI DATA FLOW e clique em <i>general</i>. Irá aparecer um formulário para apontarmos para a tarefa que relacionamos a nossa aplicação do OCI Data Flow
![image](https://user-images.githubusercontent.com/46925501/162036797-533b4719-8d36-4412-a5f8-383cd4b3d6c7.png)

* DATA INTEGRATION
Próximo Operador que vamos adicionar ao pipeline é <i>DATA INTEGRATION</i> onde vamos fazer a chamada do Fluxo que Dados que criamos nos passos anteriores. Para isso arrastar para o canvas o operador <i>DATA INTEGRATION</i> e interligar ao operador <i>OCI DATA FLOW</i> conforme imagem
![image](https://user-images.githubusercontent.com/46925501/162037244-f35c9dfb-fd2a-405e-ace7-6260567842a6.png)

Clique com o botão direito sobre o operador OCI DATA INTEGRATION e clique em <i>general</i>
Vamos realizar uma configuração similar ao operador anterior. Um ponto adicional nesse operador que em <i>Incoming link condition</i>, vamos selecionar a opção <i>Run on success of previous operator</i>
  
![image](https://user-images.githubusercontent.com/46925501/162037775-11d9a58e-e80f-4114-9744-764ed17b7583.png)

* EXPRESSION
Seguimos com o próximo operador, agora vamos adicionar ao nosso pipeline o operador <i>EXPRESSION</i>. O objetivo desse operador é coletarmos o Nome do nosso pipeline e a tarefa para que possamos fazer a ingestão dessa informação na tabela de controle.
Para isso arrastar o operador para o canvas e ligar no operador DATA INTEGRATION conforme imagem
![image](https://user-images.githubusercontent.com/46925501/162038421-d8ecbbab-da3e-4bdf-9e9a-1e0a4975d054.png)

Clique com o botão direito no operador expression e clique em <i>general</i>. Vamos adicionar um expressão nesse operador, para isso clique em ADD
![image](https://user-images.githubusercontent.com/46925501/162038801-23aa85ab-23bc-4389-947d-34f890bc6d73.png)

Configure conforme o formulário da imagem abaixo
![image](https://user-images.githubusercontent.com/46925501/162038976-babc738c-a841-4c2b-8cba-526f6436b482.png)
  
Agora Vamos adicionar <b>dois</b> operador <i>SQL</i> e ligar eles ao operador <i>EXPRESSION</i> e a saída de ambos ligar ao operador <i>END</i>
![image](https://user-images.githubusercontent.com/46925501/162039340-0a9d4f16-f12e-43a8-8846-120587a5aa14.png)

* SQL
Vamos iniciar a configuração do primeiro operador <i>SQL</i>, ele será o caminho de sucesso do nosso pipeline. Clicar com o botão direito do mouse e clicar em <i>general</i>. Vamos atribuir um nome para ele, selecionar a procedure criada e em <i>Incoming link condition</i> selecionar a opção <i>Run on success of previous operator</i>, conforme imagem
![image](https://user-images.githubusercontent.com/46925501/162039827-9f386e9a-ae0f-4e7b-aa7f-c59a1497e915.png)
  
Ainda no operador, vamos configurar os parâmetros, clicando em configuration e configure
![image](https://user-images.githubusercontent.com/46925501/162040040-087c9a38-6bae-43fb-bc99-6b485ed1e6e8.png)

Como vemos na imagem temos dois parâmetros que vamos configurar, clique em configure do parâmetro IN_DI_RESULT
![image](https://user-images.githubusercontent.com/46925501/162040269-b8fa46a3-c459-4ee9-8355-8b1434f8c608.png)

Adicione os valores igual a imagem
![image](https://user-images.githubusercontent.com/46925501/162040343-ee534ce1-efc2-4954-b17a-19b85f50d516.png)

Realize a configuração do segundo parâmetro
![image](https://user-images.githubusercontent.com/46925501/162040439-d1309b5d-7bbf-4346-91ab-4bbd301116af.png)

Adicione os valores igual a imagem
![image](https://user-images.githubusercontent.com/46925501/162040591-ede9232b-3e56-42c0-9787-453f197a3e7d.png)
  
Clique em <i>Configure</i>
  
Agora vamos configurar o segundo operador <i>SQL</i>, ele será o caminho de erro do nosso pipeline. Clicar com o botão direito do mouse e clicar em <i>general</i>. Vamos atribuir um nome para ele, selecionar a procedure criada e em <i>Incoming link condition</i> selecionar a opção <i>Run on failure of previous operator</i>, conforme imagem
![image](https://user-images.githubusercontent.com/46925501/162041027-3e3e6347-edec-4338-a990-cd6e8756c1b6.png)

Ainda no operador, vamos configurar os parâmetros, clicando em configuration e configure
![image](https://user-images.githubusercontent.com/46925501/162041137-61df1f83-92a1-48c2-b3c0-527566ee88e1.png)

Como vemos na imagem temos dois parâmetros que vamos configurar, clique em configure do parâmetro IN_DI_RESULT
![image](https://user-images.githubusercontent.com/46925501/162041309-a58fb518-fc47-4e00-986a-810fe82cb8b2.png)

Adicione os valores igual a imagem
![image](https://user-images.githubusercontent.com/46925501/162041381-b9913af2-6657-4e8c-b00a-a56c15f2b2b0.png)

Realize a configuração do segundo parâmetro
![image](https://user-images.githubusercontent.com/46925501/162041476-fe404497-0a88-4c28-8c79-43becddeee3d.png)

Adicione os valores igual a imagem
![image](https://user-images.githubusercontent.com/46925501/162041527-6a764759-1d92-4ca0-aee6-bbe29c0fc655.png)

Clique em <i>Configure</i>
  
Após finalizar a configuração do pipeline, teremos um Canvas similar a imagem abaixo. Por fim cliquem em <i>Save and close</i>
![image](https://user-images.githubusercontent.com/46925501/162041794-5005035f-df44-47a4-8113-fd294f70ebab.png)

<b>Criando Integration Task do Pipeline</b>

Clique no sinal de + e em seguida clique em Projects
  
![image](https://user-images.githubusercontent.com/46925501/162042584-c005ebc5-39a2-4ac5-8f48-2a4d6bdbd1a3.png)

Selecione seu projeto e em seguida em Task, clique em Create Task e escolha a opção Pipeline
![image](https://user-images.githubusercontent.com/46925501/162042840-48947e89-3963-40cc-9077-2dc6474e53cc.png)

Dê um nome a Pipeline Task e verifique se o seu projeto está selecionado, em seguida clique no botão Select para selecionar o Pipeline que será usado na Task
![image](https://user-images.githubusercontent.com/46925501/162043085-ec7e2ebd-b34f-4621-b4e0-a626f3309093.png)
![image](https://user-images.githubusercontent.com/46925501/162043173-17633509-a409-4f75-82a9-688004acd4c3.png)
![image](https://user-images.githubusercontent.com/46925501/162043343-73a68af2-91bd-496c-94d7-ad231db2f1f8.png)
![image](https://user-images.githubusercontent.com/46925501/162043449-02e98d24-7019-4eef-9e6b-3e5664e25041.png)

Publicando a Aplicação Clique no sinal de + e em seguida clique em Projects
![image](https://user-images.githubusercontent.com/46925501/162043527-9fa9d69a-e436-4b25-b5a6-8c471249d19f.png)

Selecione seu projeto e em seguida em Task. Selecione apenas o Pipeline que acabamos de criar e clique em <i>Publich to application</i>
![image](https://user-images.githubusercontent.com/46925501/162043938-13b7a8aa-b6b1-494f-a764-abc63df43647.png)

Selecione a sua aplicação e cliquem em Publish
![image](https://user-images.githubusercontent.com/46925501/162044008-631c28ad-9464-4444-9b39-32234f9f754f.png)

Agora clique no sinal + e selecione Application
![image](https://user-images.githubusercontent.com/46925501/162044066-d69a2b30-e14f-4e66-b1b6-3cf0728238da.png)

Acesse o Default Application que está disponível no seu Workspace
![image](https://user-images.githubusercontent.com/46925501/162044122-10c3341b-476a-449a-9ff5-918fb3e5c9d9.png)

Acesse o Default Application que está disponível no seu Workspace
![image](https://user-images.githubusercontent.com/46925501/162044507-fb06ae29-2d2d-4fd7-bd25-9b506693c7cd.png)

Ao acessar a Application você vai localizar as Integrations Task que publicamos na seção anterior.

Para executarmos, clicamos nos três pontinhos da tarefa que queromos executar e clicamos em <i></i>

![image](https://user-images.githubusercontent.com/46925501/162045513-f94f6c62-0aca-41b6-9278-cd8b1dbd72c4.png)

A execução da Integration Task vai começar e você será direcionado para a aba Runs. Você poderá utilizar o botão <i>Refresh</i> para visualizar o progresso da Integration Task
![image](https://user-images.githubusercontent.com/46925501/162045853-70b93564-0ff7-4fd3-9c22-0a5924504c65.png)

### Tópico Bonus - Scheduler
