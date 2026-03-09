# Migration from 0.5.11 to 0.5.12

## What changed

Starting in chart `0.5.12`, the chart no longer auto-manages the encryption secret.
You must provide an existing Kubernetes secret via:

- `global.encryption.existingSecret.name`
- `global.encryption.existingSecret.key`

This avoids encryption key rotation during `helm upgrade`.

## Who is impacted

You are impacted if all are true your existing HELM release:

- `global.encryption.enabled=true`
- `global.encryption.createSecret=true`
- `global.encryption.existingSecret.name` is empty

## Safe upgrade steps

1. Copy the current chart-managed encryption key into a new user-managed secret.
2. Upgrade the release and point values to that new secret.

### 1) Copy existing key to a new secret

```bash
NS=<namespace>
REL=<release-name>
OLD_SECRET="${REL}-encryption-key"            # or your custom global.encryption.secretName from 0.5.11
NEW_SECRET="${REL}-encryption-key-external"

KEY_B64=$(kubectl -n "$NS" get secret "$OLD_SECRET" -o jsonpath='{.data.encryption-key}')

cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: ${NEW_SECRET}
  namespace: ${NS}
type: Opaque
data:
  encryption-key: ${KEY_B64}
YAML
```

### 2) Upgrade and reference the external secret

```bash
helm upgrade "$REL" <chart-ref> -n "$NS" --reuse-values \
  --set global.encryption.enabled=true \
  --set global.encryption.existingSecret.name="$NEW_SECRET" \
  --set global.encryption.existingSecret.key="encryption-key"
```

Equivalent values:

```yaml
global:
  encryption:
    enabled: true
    existingSecret:
      name: <your-secret-name>
      key: encryption-key
```

## Verification

```bash
kubectl -n "$NS" get secret "$NEW_SECRET" -o jsonpath='{.data.encryption-key}' | wc -c
kubectl -n "$NS" rollout status deployment/<release>-glassflow-etl-api
```

## Important notes

- Do not reference the old chart-managed secret as `existingSecret.name` in the same upgrade where chart-managed secret creation is removed.
- Copy the key first, then upgrade.
