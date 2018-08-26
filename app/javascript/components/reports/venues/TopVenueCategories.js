import React from "react"
import PropTypes from "prop-types"

class TopVenueCategories extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      isReady: false,
    }
  }

  componentDidMount () {
    fetch(this.props.path).
      then(response => response.json()).
      then((rows) => {
        this.setState({
          isReady: true,
          rows: rows,
        });
      });
  }

  render () {
    if (this.state.isReady) {
      return (
        <table className="top-venue-categories">
          <thead>
            <tr>
              <td>Place</td>
              <td>Visits</td>
              <td>Median rating</td>
            </tr>
          </thead>
          <tbody>
            {this.state.rows.map((row) => {
              return (
                <tr key={row.name}>
                  <td>
                    <span className="top-venue-categories-avatar">
                      <img src={row.icon_prefix + 32 + row.icon_suffix} />
                    </span>
                    {row.name}
                  </td>
                  <td>{row.check_ins_count}</td>
                  <td>{row.p50_rating}</td>
                </tr>
              );
            })}
          </tbody>
        </table>
      );
    }

    return (
      <p>Loading...</p>
    );
  }
}

TopVenueCategories.propTypes = {
  path: PropTypes.string
};

export default TopVenueCategories
