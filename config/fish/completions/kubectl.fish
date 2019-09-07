
function __kubectl_c
  complete \
    --command kubectl \
    --no-files \
    --arguments "$argv"
end

__kubectl_c "(__complete_with config set-cluster __kubectl_print_clusters)"
__kubectl_c "(__complete_with config use-context __kubectl_print_contexts)"
__kubectl_c "(__complete_with logs __kubectl_print_pods)"
__kubectl_c "(__complete_with describe __kubectl_print_pods)"
__kubectl_c "(__complete_with apply -f __kubectl_print_yaml_configs)"

function __kubectl_print_clusters
  kubectl config get-clusters | strip-first-line
end

function __kubectl_print_contexts
  kubectl config get-contexts -o name
end

function __kubectl_print_pods
  if test -n "$argv[1]"
    kubectl get pods -n "$argv[1]" -o custom-columns=NAME:.metadata.name,NAMESPACE:.metadata.namespace | strip-first-line | tr " " "\t" | tr -s "\t" | cut -f1,2
  else
    kubectl get pods --all-namespaces -o custom-columns=NAME:.metadata.name,NAMESPACE:.metadata.namespace | strip-first-line | tr " " "\t" | tr -s "\t" | cut -f1,2
  end
end

function __kubectl_print_yaml_configs
  set cwd (pwd)
  set pwd_count (math (string length "$cwd") + 2)
  locate "$cwd*.yaml" | string sub --start $pwd_count
end

