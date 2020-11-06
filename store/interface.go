package store

type Filter func(obj Object) (bool, error)
type Sort func(i, j int) bool

type Query struct {
	Namespace string
	Paginate
}

type Store interface {
	IsStoreGVR(gvr GroupVersionResource) bool
	OnResourceAdded(gvr GroupVersionResource, obj interface{}) error
	OnResourceModified(gvr GroupVersionResource, obj interface{}) error
	OnResourceDeleted(gvr GroupVersionResource, obj interface{}) error
	Query(gvr GroupVersionResource, query Query) QueryResult
	Get(gvr GroupVersionResource, namespace, name string) interface{}
}
