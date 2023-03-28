# Дипломный практикум в Yandex.Cloud
  * [Цели:](#цели)
  * [Этапы выполнения:](#этапы-выполнения)
     * [Создание облачной инфраструктуры](#создание-облачной-инфраструктуры)
     * [Создание Kubernetes кластера](#создание-kubernetes-кластера)
     * [Создание тестового приложения](#создание-тестового-приложения)
     * [Подготовка cистемы мониторинга и деплой приложения](#подготовка-cистемы-мониторинга-и-деплой-приложения)
     * [Установка и настройка CI/CD](#установка-и-настройка-cicd)
  * [Что необходимо для сдачи задания?](#что-необходимо-для-сдачи-задания)
  * [Как правильно задавать вопросы дипломному руководителю?](#как-правильно-задавать-вопросы-дипломному-руководителю)

---
## Цели:

1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.
2. Запустить и сконфигурировать Kubernetes кластер.
3. Установить и настроить систему мониторинга.
4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.
5. Настроить CI для автоматической сборки и тестирования.
6. Настроить CD для автоматического развёртывания приложения.

---
## Этапы выполнения:


### Создание облачной инфраструктуры

Для начала необходимо подготовить облачную инфраструктуру в ЯО при помощи [Terraform](https://www.terraform.io/).

Особенности выполнения:

- Бюджет купона ограничен, что следует иметь в виду при проектировании инфраструктуры и использовании ресурсов;
- Следует использовать последнюю стабильную версию [Terraform](https://www.terraform.io/).

Предварительная подготовка к установке и запуску Kubernetes кластера.

1. Создайте сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой с необходимыми и достаточными правами. Не стоит использовать права суперпользователя
2. Подготовьте [backend](https://www.terraform.io/docs/language/settings/backends/index.html) для Terraform:  
   а. Рекомендуемый вариант: [Terraform Cloud](https://app.terraform.io/)  
   б. Альтернативный вариант: S3 bucket в созданном ЯО аккаунте
3. Настройте [workspaces](https://www.terraform.io/docs/language/state/workspaces.html)  
   а. Рекомендуемый вариант: создайте два workspace: *stage* и *prod*. В случае выбора этого варианта все последующие шаги должны учитывать факт существования нескольких workspace.  
   б. Альтернативный вариант: используйте один workspace, назвав его *stage*. Пожалуйста, не используйте workspace, создаваемый Terraform-ом по-умолчанию (*default*).
4. Создайте VPC с подсетями в разных зонах доступности.
5. Убедитесь, что теперь вы можете выполнить команды `terraform destroy` и `terraform apply` без дополнительных ручных действий.
6. В случае использования [Terraform Cloud](https://app.terraform.io/) в качестве [backend](https://www.terraform.io/docs/language/settings/backends/index.html) убедитесь, что применение изменений успешно проходит, используя web-интерфейс Terraform cloud.

Ожидаемые результаты:

1. Terraform сконфигурирован и создание инфраструктуры посредством Terraform возможно без дополнительных ручных действий.
2. Полученная конфигурация инфраструктуры является предварительной, поэтому в ходе дальнейшего выполнения задания возможны изменения.

## Terraform сконфигурирован для создания инфраструктуры 
```shell script
{   
    cd /terraform
    terraform init
    terraform validate
    terraform plan
    terraform apply -auto-approve
}
```
![image](https://user-images.githubusercontent.com/40559167/226113375-50e3077e-bd60-43e6-b588-bdf6771d5bd8.png)
![image](https://user-images.githubusercontent.com/40559167/226113392-48e39563-0074-47c3-87d7-1867f64e84e0.png)
---
### Создание Kubernetes кластера

На этом этапе необходимо создать [Kubernetes](https://kubernetes.io/ru/docs/concepts/overview/what-is-kubernetes/) кластер на базе предварительно созданной инфраструктуры.   Требуется обеспечить доступ к ресурсам из Интернета.

Это можно сделать двумя способами:

1. Рекомендуемый вариант: самостоятельная установка Kubernetes кластера.  
   а. При помощи Terraform подготовить как минимум 3 виртуальных машины Compute Cloud для создания Kubernetes-кластера. Тип виртуальной машины следует выбрать самостоятельно с учётом требовании к производительности и стоимости. Если в дальнейшем поймете, что необходимо сменить тип инстанса, используйте Terraform для внесения изменений.  
   б. Подготовить [ansible](https://www.ansible.com/) конфигурации, можно воспользоваться, например [Kubespray](https://kubernetes.io/docs/setup/production-environment/tools/kubespray/)  
   в. Задеплоить Kubernetes на подготовленные ранее инстансы, в случае нехватки каких-либо ресурсов вы всегда можете создать их при помощи Terraform.
2. Альтернативный вариант: воспользуйтесь сервисом [Yandex Managed Service for Kubernetes](https://cloud.yandex.ru/services/managed-kubernetes)  
  а. С помощью terraform resource для [kubernetes](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster) создать региональный мастер kubernetes с размещением нод в разных 3 подсетях      
  б. С помощью terraform resource для [kubernetes node group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group)
  
Ожидаемый результат:

1. Работоспособный Kubernetes кластер.
2. В файле `~/.kube/config` находятся данные для доступа к кластеру.
3. Команда `kubectl get pods --all-namespaces` отрабатывает без ошибок.

### Деплой кластера
```shell script
# Длz деплоя кластера используем kubespray
{
    cd ../ansible/
    ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -v

}
```
### Доступ к управлению кластером под root
```shell script
# Копируем конфиг в домашнюю папку пользователя для управления кластером 
{
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
}
```
### В файле `~/.kube/config` находятся данные для доступа к кластеру.
```shell
root@www:~/Desktop/devops-diplom-yandexcloud$ cat ~/.kube/config
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: 
    server: https://158.160.58.54:6443
  name: cluster.local
contexts:
- context:
    cluster: cluster.local
    user: kubernetes-admin
  name: kubernetes-admin@cluster.local
current-context: kubernetes-admin@cluster.local
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: 
    client-key-data: 
 ```

### Команда `kubectl get pods --all-namespaces` отрабатывает без ошибок.
```shell
www@www:~/Desktop/CI/sl/other_service/kubernetes/helm$ sudo kubectl get po -A
NAMESPACE     NAME                                                READY   STATUS    RESTARTS      AGE
argocd        argocd-application-controller-0                     1/1     Running   0             11h
argocd        argocd-applicationset-controller-676749c97d-8z5dd   1/1     Running   0             11h
argocd        argocd-dex-server-68fdffbdb6-rhh5v                  1/1     Running   0             11h
argocd        argocd-notifications-controller-56578cd466-5pq92    1/1     Running   0             11h
argocd        argocd-redis-8f7689686-2rcsz                        1/1     Running   0             11h
argocd        argocd-repo-server-658b549674-qgsmg                 1/1     Running   0             11h
argocd        argocd-server-5b69986577-gflrn                      1/1     Running   0             11h
default       app-app-chart-c4dd5f584-grgr6                       1/1     Running   0             10h
default       pod-with-error                                      1/1     Running   0             12h
kube-system   calico-kube-controllers-d6484b75c-2k8sm             1/1     Running   0             16h
kube-system   calico-node-t7pd5                                   1/1     Running   0             16h
kube-system   calico-node-vz5nx                                   1/1     Running   0             16h
kube-system   coredns-588bb58b94-hqlzd                            1/1     Running   0             16h
kube-system   coredns-588bb58b94-mnhlz                            1/1     Running   0             16h
kube-system   dns-autoscaler-5b9959d7fc-vhz6s                     1/1     Running   0             16h
kube-system   kube-apiserver-node1                                1/1     Running   1             16h
kube-system   kube-controller-manager-node1                       1/1     Running   3 (16h ago)   16h
kube-system   kube-proxy-924md                                    1/1     Running   0             16h
kube-system   kube-proxy-llnlp                                    1/1     Running   0             16h
kube-system   kube-scheduler-node1                                1/1     Running   2 (16h ago)   16h
kube-system   metrics-server-5c9dd56466-9fjcr                     1/1     Running   1 (16h ago)   16h
kube-system   nginx-proxy-node2                                   1/1     Running   0             16h
kube-system   nodelocaldns-gzrg4                                  1/1     Running   0             16h
kube-system   nodelocaldns-qpd74                                  1/1     Running   0             16h
monitoring    alertmanager-main-0                                 2/2     Running   0             11h
monitoring    alertmanager-main-1                                 2/2     Running   0             11h
monitoring    alertmanager-main-2                                 2/2     Running   0             11h
monitoring    blackbox-exporter-6fd586b445-x7l9s                  3/3     Running   0             11h
monitoring    grafana-58bbb48f66-sbzgk                            1/1     Running   0             11h
monitoring    kube-state-metrics-9c686fb69-dsp5p                  3/3     Running   0             11h
monitoring    node-exporter-qfkpf                                 2/2     Running   0             11h
monitoring    node-exporter-rvlgv                                 2/2     Running   0             11h
monitoring    prometheus-adapter-77f56b865b-qfkvp                 1/1     Running   0             11h
monitoring    prometheus-adapter-77f56b865b-wrhwm                 1/1     Running   0             11h
monitoring    prometheus-k8s-0                                    2/2     Running   0             11h
monitoring    prometheus-k8s-1                                    2/2     Running   0             11h
monitoring    prometheus-operator-65ff8b668d-ms76c                2/2     Running   0             11h
```
### Создание тестового приложения

Для перехода к следующему этапу необходимо подготовить тестовое приложение, эмулирующее основное приложение разрабатываемое вашей компанией.

Способ подготовки:

1. Рекомендуемый вариант:  
   а. Создайте отдельный git репозиторий с простым nginx конфигом, который будет отдавать статические данные.  
   б. Подготовьте Dockerfile для создания образа приложения.  
2. Альтернативный вариант:  
   а. Используйте любой другой код, главное, чтобы был самостоятельно создан Dockerfile.

Ожидаемый результат:

1. Git репозиторий с тестовым приложением и Dockerfile.
2. Регистр с собранным docker image. В качестве регистра может быть DockerHub или [Yandex Container Registry](https://cloud.yandex.ru/services/container-registry), созданный также с помощью terraform.

### Git репозиторий с тестовым приложением и Dockerfile.
https://github.com/webdotwork/yadex-cloud/tree/main/app
https://itlab.gitlab.yandexcloud.net/webdotwork/devops.git

### Регистр с собранным docker image. В качестве регистра может быть DockerHub
https://hub.docker.com/r/webdotwork/app_app
itlab.gitlab.yandexcloud.net:5050/webdotwork/devops/master:caa4e832
cr.yandex/crpe9jjj2fi85t0c29b6/hello:gitlab-546a3cd2
---
### Подготовка cистемы мониторинга и деплой приложения

Уже должны быть готовы конфигурации для автоматического создания облачной инфраструктуры и поднятия Kubernetes кластера.  
Теперь необходимо подготовить конфигурационные файлы для настройки нашего Kubernetes кластера.

Цель:
1. Задеплоить в кластер [prometheus](https://prometheus.io/), [grafana](https://grafana.com/), [alertmanager](https://github.com/prometheus/alertmanager), [экспортер](https://github.com/prometheus/node_exporter) основных метрик Kubernetes.
2. Задеплоить тестовое приложение, например, [nginx](https://www.nginx.com/) сервер отдающий статическую страницу.

Рекомендуемый способ выполнения:
1. Воспользовать пакетом [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus), который уже включает в себя [Kubernetes оператор](https://operatorhub.io/) для [grafana](https://grafana.com/), [prometheus](https://prometheus.io/), [alertmanager](https://github.com/prometheus/alertmanager) и [node_exporter](https://github.com/prometheus/node_exporter). При желании можете собрать все эти приложения отдельно.
2. Для организации конфигурации использовать [qbec](https://qbec.io/), основанный на [jsonnet](https://jsonnet.org/). Обратите внимание на имеющиеся функции для интеграции helm конфигов и [helm charts](https://helm.sh/)
3. Если на первом этапе вы не воспользовались [Terraform Cloud](https://app.terraform.io/), то задеплойте в кластер [atlantis](https://www.runatlantis.io/) для отслеживания изменений инфраструктуры.

Альтернативный вариант:
1. Для организации конфигурации можно использовать [helm charts](https://helm.sh/)

Ожидаемый результат:
1. Git репозиторий с конфигурационными файлами для настройки Kubernetes.
2. Http доступ к web интерфейсу grafana.
3. Дашборды в grafana отображающие состояние Kubernetes кластера.
4. Http доступ к тестовому приложению.

###  Git репозиторий с конфигурационными файлами для настройки Kubernetes.
https://github.com/webdotwork/yadex-cloud/tree/main/app-chart

### Http доступ к web интерфейсу grafana
http://51.250.22.4:30300/login

## Дашборды в grafana отображающие состояние Kubernetes кластера.
![image](https://user-images.githubusercontent.com/40559167/228157763-131d6e7f-50b1-4919-ae11-4277c7424c7e.png)
![image](https://user-images.githubusercontent.com/40559167/228157867-2a10131d-c8f8-4c54-8ada-8efd00edb87e.png)
![image](https://user-images.githubusercontent.com/40559167/228158109-a5088270-b0c4-40fd-988b-7143c36b490f.png)
![image](https://user-images.githubusercontent.com/40559167/228158175-9c466d19-05b3-48cc-bdfc-59d319a077d0.png)

## Http доступ к тестовому приложению.
http://51.250.22.4:30557/
---
### Установка и настройка CI/CD

Осталось настроить ci/cd систему для автоматической сборки docker image и деплоя приложения при изменении кода.

Цель:

1. Автоматическая сборка docker образа при коммите в репозиторий с тестовым приложением.
2. Автоматический деплой нового docker образа.

Можно использовать [teamcity](https://www.jetbrains.com/ru-ru/teamcity/), [jenkins](https://www.jenkins.io/) либо [gitlab ci](https://about.gitlab.com/stages-devops-lifecycle/continuous-integration/)

Ожидаемый результат:

1. Интерфейс ci/cd сервиса доступен по http.
2. При любом коммите в репозиторие с тестовым приложением происходит сборка и отправка в регистр Docker образа.
3. При создании тега (например, v1.0.0) происходит сборка и отправка с соответствующим label в регистр, а также деплой соответствующего Docker образа в кластер Kubernetes.

---
## Что необходимо для сдачи задания?

1. Репозиторий с конфигурационными файлами Terraform и готовность продемонстрировать создание всех ресурсов с нуля.
2. Пример pull request с комментариями созданными atlantis'ом или снимки экрана из Terraform Cloud.
3. Репозиторий с конфигурацией ansible, если был выбран способ создания Kubernetes кластера при помощи ansible.
4. Репозиторий с Dockerfile тестового приложения и ссылка на собранный docker image.
5. Репозиторий с конфигурацией Kubernetes кластера.
6. Ссылка на тестовое приложение и веб интерфейс Grafana с данными доступа.
7. Все репозитории рекомендуется хранить на одном ресурсе (github, gitlab)

---
## Как правильно задавать вопросы дипломному руководителю?

Что поможет решить большинство частых проблем:

1. Попробовать найти ответ сначала самостоятельно в интернете или в 
  материалах курса и ДЗ и только после этого спрашивать у дипломного 
  руководителя. Скилл поиска ответов пригодится вам в профессиональной 
  деятельности.
2. Если вопросов больше одного, то присылайте их в виде нумерованного 
  списка. Так дипломному руководителю будет проще отвечать на каждый из 
  них.
3. При необходимости прикрепите к вопросу скриншоты и стрелочкой 
  покажите, где не получается.

Что может стать источником проблем:

1. Вопросы вида «Ничего не работает. Не запускается. Всё сломалось». 
  Дипломный руководитель не сможет ответить на такой вопрос без 
  дополнительных уточнений. Цените своё время и время других.
2. Откладывание выполнения курсового проекта на последний момент.
3. Ожидание моментального ответа на свой вопрос. Дипломные руководители работающие разработчики, которые занимаются, кроме преподавания, 
  своими проектами. Их время ограничено, поэтому постарайтесь задавать правильные вопросы, чтобы получать быстрые ответы :)
